import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/common/presentation/inputs/multiline_text_field.dart';
import 'package:lab_house/core/api/model/openai_model.m.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/ranking/bloc/ranking_bloc.dart';

class SearchRankingToast extends StatelessWidget with LocaleManager {
  SearchRankingToast({super.key});

  final _fieldKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return BlocConsumer<RankingBloc, RankingState>(
      listenWhen: (prev, curr) => prev.isGenerating && !curr.isGenerating,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) {
        return PopScope(
          canPop: !state.isGenerating,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lc.new_ranking_title,
                style: LabhouseTextTheme.semibold(
                  color: JGColors.nightAtDisco,
                  size: 22,
                ),
              ),
              const SizedBox(height: 16),
              MultilineTextField(
                fieldKey: _fieldKey,
                placeholder: lc.new_ranking_placeholder,
                maxLimit: 200,
              ),
              const SizedBox(height: 24),
              state.isGenerating
                  ? const _GeneratingButton()
                  : LabhouseButton(
                      text: lc.search,
                      onPressed: () => _search(context),
                    ),
            ],
          ),
        );
      },
    );
  }

  // MARK: - Private Methods

  void _search(BuildContext context) {
    final query = (_fieldKey.currentState?.value as String?)?.trim() ?? '';

    if (query.isEmpty) return;

    context.read<RankingBloc>().add(
      RankingGeneration(query: query, model: OpenAIModel.gpt4oMini),
    );
  }
}

class _GeneratingButton extends StatelessWidget {
  const _GeneratingButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: JGColors.primaryTurquoise,
        borderRadius: LabhouseElevatedButtonTheme.defaultRadius,
      ),
      child: const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.white),
      ),
    );
  }
}
