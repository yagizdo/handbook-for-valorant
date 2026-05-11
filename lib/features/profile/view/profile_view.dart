import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_cubit.dart';
import 'package:handbook_for_valorant/features/profile/widget/about_section.dart';
import 'package:handbook_for_valorant/features/profile/widget/data_section.dart';
import 'package:handbook_for_valorant/features/profile/widget/preferences_section.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<ProfileCubit>().initialize());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(Dimensions.k16, Dimensions.k20, Dimensions.k16, Dimensions.k4),
              child: Text(LocaleKeys.settings_title.tr(), style: context.textTheme.headlineLarge),
            ),
            Gaps.g16,
            Padding(
              key: ValueKey(context.locale),
              padding: const EdgeInsets.symmetric(horizontal: Dimensions.k16),
              child: const Column(
                children: [PreferencesSection(), Gaps.g24, DataSection(), Gaps.g24, AboutSection(), Gaps.g32],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
