import 'dart:async';

import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_cubit.dart';
import 'package:handbook_for_valorant/product/widgets/settings/product_settings_group.dart';
import 'package:handbook_for_valorant/product/widgets/settings/product_settings_tile.dart';
import 'package:theme_module/theme_module.dart';

class PreferencesSection extends StatelessWidget {
  const PreferencesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductSettingsGroup(
      label: LocaleKeys.settings_section_preferences.tr(),
      children: [
        const _DarkModeToggle(),
        _LanguageTile(currentLocale: context.locale),
      ],
    );
  }
}

class _DarkModeToggle extends StatelessWidget {
  const _DarkModeToggle();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, themeState) {
        return ProductSettingsTile.toggle(
          label: LocaleKeys.settings_preferences_darkMode.tr(),
          value: themeState.isDarkMode,
          onChanged: (_) => context.read<ThemeCubit>().toggleTheme(),
        );
      },
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({required this.currentLocale});
  final Locale currentLocale;

  String get _displayName {
    if (currentLocale.languageCode == 'tr') return LocaleKeys.settings_language_turkish.tr();
    return LocaleKeys.settings_language_english.tr();
  }

  @override
  Widget build(BuildContext context) {
    return ProductSettingsTile.navigation(
      label: LocaleKeys.settings_preferences_language.tr(),
      value: _displayName,
      onTap: () => _showLanguageSheet(context),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: context.colorScheme.surfaceContainerHighest,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.k16))),
        builder: (_) => const _LanguagePickerSheet(),
      ),
    );
  }
}

class _LanguagePickerSheet extends StatelessWidget {
  const _LanguagePickerSheet();

  @override
  Widget build(BuildContext context) {
    final currentLocale = context.locale;
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimensions.k16),
            child: Text(LocaleKeys.settings_language_title.tr(), style: context.textTheme.titleMedium),
          ),
          _LanguageOption(
            label: LocaleKeys.settings_language_english.tr(),
            locale: const Locale('en', 'US'),
            isSelected: currentLocale.languageCode == 'en',
          ),
          _LanguageOption(
            label: LocaleKeys.settings_language_turkish.tr(),
            locale: const Locale('tr', 'TR'),
            isSelected: currentLocale.languageCode == 'tr',
          ),
          Gaps.g16,
        ],
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({required this.label, required this.locale, required this.isSelected});
  final String label;
  final Locale locale;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(label),
      trailing: isSelected ? Icon(Icons.check, color: context.colorScheme.primary) : null,
      onTap: () => _onLanguageSelected(context),
    );
  }

  void _onLanguageSelected(BuildContext context) {
    context.read<ProfileCubit>().changeLanguage('${locale.languageCode}-${locale.countryCode}');
    unawaited(context.setLocale(locale));
    Navigator.of(context).pop();
  }
}
