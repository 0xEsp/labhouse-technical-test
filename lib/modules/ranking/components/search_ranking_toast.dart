import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/common/presentation/focus/lose_focus_on_tap.dart';
import 'package:lab_house/common/presentation/inputs/multiline_text_field.dart';
import 'package:lab_house/core/api/model/openai_model.m.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/ranking/bloc/ranking_bloc.dart';

class SearchRankingToast extends StatelessWidget with LocaleManager {
  SearchRankingToast({super.key});

  final _fieldKey = GlobalKey<FormFieldState>();
  static const rankingQueryMaxLength = 200;

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return BlocConsumer<RankingBloc, RankingState>(
      listenWhen: (prev, curr) => prev.isGenerating && !curr.isGenerating,
      listener: (context, _) => Navigator.of(context).pop(),
      builder: (context, state) {
        return PopScope(
          canPop: !state.isGenerating,
          child: LoseFocusOnTap(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lc.new_ranking_title,
                  style: LabhouseTextTheme.semibold(
                    color: JGColors.onSurface(context),
                    size: 22,
                  ),
                ),
                const SizedBox(height: 16),
                MultilineTextField(
                  fieldKey: _fieldKey,
                  placeholder: lc.new_ranking_placeholder,
                  maxLimit: rankingQueryMaxLength,
                  validator: (value) => _validate(context, value),
                ),
                const SizedBox(height: 24),
                LabhouseButton(
                  text: lc.search,
                  loading: state.isGenerating,
                  onPressed: () => _search(context),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // MARK: - Private Methods

  String? _validate(BuildContext context, String? value) {
    final lc = locale(context);
    final text = value?.trim() ?? '';

    if (text.isEmpty) return lc.mandatory_field;
    if (text.length > rankingQueryMaxLength) {
      return lc.ranking_query_too_long(rankingQueryMaxLength);
    }

    return null;
  }

  void _search(BuildContext context) {
    if (!(_fieldKey.currentState?.validate() ?? false)) return;

    final query = (_fieldKey.currentState?.value as String?)?.trim() ?? '';

    context.read<RankingBloc>().add(
      RankingGeneration(query: query, model: OpenAIModel.gpt4oMini),
    );
  }
}
