import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_cubit.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_state.dart';
import 'package:handbook_for_valorant/product/widgets/settings/product_settings_group.dart';
import 'package:handbook_for_valorant/product/widgets/settings/product_settings_tile.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ProductSettingsGroup(
      label: LocaleKeys.settings_section_about.tr(),
      children: [
        const _VersionTile(),
        const _RateAppTile(),
        ProductSettingsTile.navigation(label: LocaleKeys.settings_about_privacyPolicy.tr(), value: '', onTap: () {}),
        ProductSettingsTile.navigation(label: LocaleKeys.settings_about_termsOfService.tr(), value: '', onTap: () {}),
      ],
    );
  }
}

class _VersionTile extends StatelessWidget {
  const _VersionTile();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<ProfileCubit, ProfileState, String>(
      selector: (state) => state.appVersion,
      builder: (context, appVersion) {
        return ProductSettingsTile.value(
          label: LocaleKeys.settings_about_appVersion.tr(),
          value: appVersion.isEmpty ? '-' : appVersion,
        );
      },
    );
  }
}

class _RateAppTile extends StatelessWidget {
  const _RateAppTile();

  @override
  Widget build(BuildContext context) {
    return ProductSettingsTile.action(
      label: LocaleKeys.settings_about_rateApp.tr(),
      icon: Icons.star_outline,
      onTap: () => context.read<ProfileCubit>().requestReview(),
    );
  }
}
