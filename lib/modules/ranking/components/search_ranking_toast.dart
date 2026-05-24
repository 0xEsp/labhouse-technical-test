import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/common/presentation/button/labhouse_button.dart';
import 'package:lab_house/common/presentation/focus/lose_focus_on_tap.dart';
import 'package:lab_house/common/presentation/inputs/multiline_text_field.dart';
import 'package:lab_house/core/api/model/openai_model.m.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/extensions/theme/labhouse_theme.dart';
import 'package:lab_house/modules/ranking/bloc/ranking_bloc.dart';
import 'package:lab_house/modules/ranking/model/ranking_generation_input.m.dart';

class SearchRankingToast extends StatelessWidget with LocaleManager {
  SearchRankingToast({super.key});

  final _fieldKey = GlobalKey<FormFieldState>();
  final _model = ValueNotifier<OpenAIModel>(OpenAIModel.defaultModel);
  final _webSearch = ValueNotifier<bool>(false);
  static const rankingQueryMaxLength = 200;

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return BlocConsumer<RankingBloc, RankingState>(
      listenWhen: (prev, curr) => prev.isGenerating && !curr.isGenerating,
      listener: (context, state) {
        if (state.error == null) Navigator.of(context).pop();
      },
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
                Text(
                  lc.new_ranking_model_label,
                  style: LabhouseTextTheme.medium(
                    size: 13,
                    color: JGColors.primaryGrey50,
                  ),
                ),
                const SizedBox(height: 8),
                _modelPicker(context),
                const SizedBox(height: 16),
                _webSearchToggle(context),
                const SizedBox(height: 24),
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

  Widget _modelPicker(BuildContext context) {
    return ValueListenableBuilder<OpenAIModel>(
      valueListenable: _model,
      builder: (context, selected, _) => Wrap(
        spacing: 8,
        runSpacing: 8,
        children: OpenAIModel.values.map((model) {
          final isSelected = model == selected;

          return GestureDetector(
            onTap: () => _model.value = model,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: isSelected
                    ? JGColors.primaryTurquoise
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? JGColors.primaryTurquoise
                      : JGColors.primaryGrey20,
                ),
              ),
              child: Text(
                model.label,
                style: LabhouseTextTheme.medium(
                  size: 13,
                  color: isSelected
                      ? Colors.white
                      : JGColors.onSurface(context),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _webSearchToggle(BuildContext context) {
    final lc = locale(context);

    return ValueListenableBuilder<bool>(
      valueListenable: _webSearch,
      builder: (context, enabled, _) => GestureDetector(
        onTap: () => _webSearch.value = !enabled,
        behavior: HitTestBehavior.opaque,
        child: Row(
          children: [
            Icon(
              enabled
                  ? Icons.check_box_rounded
                  : Icons.check_box_outline_blank_rounded,
              color: enabled
                  ? JGColors.primaryTurquoise
                  : JGColors.primaryGrey50,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              lc.new_ranking_web_search,
              style: LabhouseTextTheme.medium(
                size: 14,
                color: JGColors.onSurface(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      RankingGeneration(
        RankingGenerationInput(
          query: query,
          model: _model.value,
          webSearch: _webSearch.value,
        ),
      ),
    );
  }
}
