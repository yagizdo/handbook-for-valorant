import 'package:core/widget/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/agents/cubit/agent_cubit.dart';
import 'package:handbook_for_valorant/features/maps/cubit/map_cubit.dart';
import 'package:handbook_for_valorant/features/profile/cubit/profile_cubit.dart';
import 'package:handbook_for_valorant/features/ranks/cubit/ranks_cubit.dart';
import 'package:handbook_for_valorant/features/weapons/cubit/weapon_cubit.dart';
import 'package:handbook_for_valorant/product/config/product_localization.dart';
import 'package:handbook_for_valorant/product/cubit/connectivity_cubit.dart';
import 'package:handbook_for_valorant/product/init/app_init.dart';
import 'package:handbook_for_valorant/product/locator/base_container.dart';
import 'package:handbook_for_valorant/product/router/app_router.dart';
import 'package:theme_module/theme_module.dart';

Future<void> main() async {
  await AppInit.make();
  runApp(ProductLocalization(child: const ValorantApp()));
}

class ValorantApp extends StatelessWidget {
  const ValorantApp({super.key});

  @override
  Widget build(BuildContext context) {
    final container = BaseContainer.instance;
    container.networkModel.language = Locales.current(context).apiLanguageCode;

    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: container.themeCubit),
        BlocProvider<ConnectivityCubit>.value(value: container.connectivityCubit),
        BlocProvider<AgentCubit>.value(value: container.agentCubit),
        BlocProvider<MapCubit>.value(value: container.mapCubit),
        BlocProvider<WeaponCubit>.value(value: container.weaponCubit),
        BlocProvider<RanksCubit>.value(value: container.ranksCubit),
        BlocProvider<ProfileCubit>.value(value: container.profileCubit),
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: LocaleKeys.app_title.tr(),
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: AppTheme.toThemeMode(state.themeType),
            routerConfig: AppRouter.appRouter.config(),
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            localizationsDelegates: [...context.localizationDelegates],
            builder: (context, child) => DismissKeyboard(child: child!),
          );
        },
      ),
    );
  }
}
