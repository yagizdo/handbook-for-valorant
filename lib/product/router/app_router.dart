import 'package:auto_route/auto_route.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Page,Route')
final class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: MainShellRoute.page,
      children: [
        AutoRoute(path: 'agents', page: AgentsRoute.page),
        AutoRoute(path: 'maps', page: MapsRoute.page),
        AutoRoute(path: 'weapons', page: WeaponsRoute.page),
        AutoRoute(path: 'ranks', page: RanksRoute.page),
        AutoRoute(path: 'profile', page: ProfileRoute.page),
      ],
    ),
    AutoRoute(path: '/agent-detail', page: AgentDetailRoute.page),
    AutoRoute(path: '/map-detail', page: MapDetailRoute.page),
    AutoRoute(path: '/weapon-detail', page: WeaponDetailRoute.page),
    AutoRoute(path: '/weapon-skins', page: WeaponSkinsRoute.page),
    AutoRoute(path: '/skin-detail', page: SkinDetailRoute.page),
  ];

  static final appRouter = AppRouter();
}
