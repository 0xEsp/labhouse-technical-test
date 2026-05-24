import 'dart:convert';

import 'package:lab_house/core/api/model/api_response_error.m.dart';
import 'package:lab_house/core/api/prompt/prompts.dart';
import 'package:lab_house/core/api/prompt/ranking.prompt.dart';
import 'package:lab_house/core/data_service.dart';
import 'package:lab_house/modules/ranking/model/ranking.dto.m.dart';
import 'package:lab_house/modules/ranking/model/ranking.m.dart';
import 'package:lab_house/modules/ranking/model/ranking_generation_input.m.dart';

abstract class GenerateRankingUseCase {
  Future<Ranking> execute(RankingGenerationInput input);
}

class GenerateRankingUseCaseDefault
    with DataService
    implements GenerateRankingUseCase {
  // MARK: - Public Methods

  @override
  Future<Ranking> execute(RankingGenerationInput input) async {
    final RankingDTO dto = await request<RankingDTO>(
      path: ApiEndpoint.responses.path,
      method: HTTPMethod.post,
      body: {
        'model': input.model.id,
        'instructions': Prompts.rankings.instruction,
        'input': input.query,
        'text': {
          'format': {
            'type': 'json_schema',
            'name': 'ranking',
            'strict': true,
            'schema': rankingResponseSchema,
          },
        },
        if (input.webSearch)
          'tools': [
            {'type': 'web_search_preview'},
          ],
      },
      resultParser: _parseResponse,
    );

    await save<RankingDTO>(dto);

    return Ranking.fromDTO(dto);
  }

  // MARK: - Private Methods

  RankingDTO _parseResponse(Object? json) {
    final response = json as Map<String, dynamic>;
    final decoded = jsonDecode(_extractOutputText(response));

    if (decoded is! Map<String, dynamic>) {
      throw ARPError(
        type: ARPErrorType.internal,
        reason: 'Malformed ranking payload',
      );
    }

    final error = decoded['error'];
    if (error != null) {
      throw ARPError(
        type: ARPErrorType.invalidRequest,
        reason: error is Map<String, dynamic>
            ? (error['message']?.toString() ?? 'Not a ranking request')
            : error.toString(),
      );
    }

    return RankingDTO.fromJson(decoded);
  }

  String _extractOutputText(Map<String, dynamic> response) {
    final output = response['output'];

    if (output is List) {
      for (final item in output) {
        if (item is! Map || item['type'] != 'message') continue;

        final content = item['content'];
        if (content is! List) continue;

        for (final part in content) {
          if (part is Map &&
              part['type'] == 'output_text' &&
              part['text'] is String) {
            return part['text'] as String;
          }
        }
      }
    }

    throw ARPError(
      type: ARPErrorType.internal,
      reason: 'OpenAI response had no output text',
    );
  }
}
