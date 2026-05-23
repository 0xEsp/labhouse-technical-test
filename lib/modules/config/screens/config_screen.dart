import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_house/core/managers/locale_manager.dart';
import 'package:lab_house/core/managers/navigation_manager.dart';
import 'package:lab_house/l10n/generated/app_localizations.dart';
import 'package:lab_house/modules/config/bloc/settings_cubit.dart';
import 'package:lab_house/modules/config/components/api_key_toast.dart';
import 'package:lab_house/modules/config/components/settings_option_toast.dart';
import 'package:lab_house/modules/config/components/settings_tile.dart';
import 'package:lab_house/modules/config/model/app_language.m.dart';
import 'package:lab_house/modules/config/model/app_theme_mode.m.dart';

class ConfigScreen extends StatefulWidget {
  const ConfigScreen({super.key});

  @override
  State<ConfigScreen> createState() => _ConfigScreenState();
}

class _ConfigScreenState extends State<ConfigScreen>
    with LocaleManager, NavigationManager {
  // MARK: - Build

  @override
  Widget build(BuildContext context) {
    final lc = locale(context);

    return Scaffold(
      appBar: AppBar(title: Text(lc.config_tap_copy)),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return SafeArea(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 120),
              children: [
                SettingsTile(
                  icon: Icons.dark_mode_outlined,
                  title: lc.settings_appearance,
                  value: _themeLabel(lc, state.themeMode),
                  onTap: () => _showAppearanceToast(context, state),
                ),
                const SizedBox(height: 12),
                SettingsTile(
                  icon: Icons.language_outlined,
                  title: lc.settings_language,
                  value: _languageLabel(lc, state.language),
                  onTap: () => _showLanguageToast(context, state),
                ),
                const SizedBox(height: 12),
                SettingsTile(
                  icon: Icons.key_outlined,
                  title: lc.settings_api_key,
                  value: state.hasApiKey
                      ? state.maskedApiKey
                      : lc.api_key_empty,
                  onTap: () => _showApiKeyToast(context, state),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // MARK: - Toasts

  void _showAppearanceToast(BuildContext context, SettingsState state) {
    final lc = locale(context);
    final cubit = context.read<SettingsCubit>();

    toast(
      context,
      child: SettingsOptionToast<AppThemeMode>(
        title: lc.settings_appearance,
        confirmLabel: lc.accept,
        current: state.themeMode,
        options: [
          SettingsOption(value: AppThemeMode.light, label: lc.appearance_light),
          SettingsOption(value: AppThemeMode.dark, label: lc.appearance_dark),
        ],
        onConfirm: cubit.changeTheme,
      ),
    );
  }

  void _showLanguageToast(BuildContext context, SettingsState state) {
    final lc = locale(context);
    final cubit = context.read<SettingsCubit>();

    toast<void>(
      context,
      child: SettingsOptionToast<AppLanguage>(
        title: lc.settings_language,
        confirmLabel: lc.accept,
        current: state.language,
        options: [
          SettingsOption(
            value: AppLanguage.english,
            label: lc.language_english,
          ),
          SettingsOption(
            value: AppLanguage.spanish,
            label: lc.language_spanish,
          ),
        ],
        onConfirm: cubit.changeLanguage,
      ),
    );
  }

  void _showApiKeyToast(BuildContext context, SettingsState state) {
    final cubit = context.read<SettingsCubit>();

    toast(
      context,
      handleKeyboard: true,
      child: ApiKeyToast(
        maskedApiKey: state.maskedApiKey,
        hasApiKey: state.hasApiKey,
        onSave: cubit.saveApiKey,
      ),
    );
  }

  // MARK: - Private Methods

  String _themeLabel(AppLocalizations lc, AppThemeMode mode) => switch (mode) {
    AppThemeMode.light => lc.appearance_light,
    AppThemeMode.dark => lc.appearance_dark,
  };

  String _languageLabel(AppLocalizations lc, AppLanguage language) =>
      switch (language) {
        AppLanguage.english => lc.language_english,
        AppLanguage.spanish => lc.language_spanish,
      };
}
