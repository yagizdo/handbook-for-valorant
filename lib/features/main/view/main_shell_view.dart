import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class MainShellView extends StatelessWidget {
  const MainShellView({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: const [AgentsRoute(), MapsRoute(), WeaponsRoute(), RanksRoute(), ProfileRoute()],
      transitionBuilder: (context, child, animation) => FadeTransition(opacity: animation, child: child),
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          body: child,
          bottomNavigationBar: NavigationBar(
            selectedIndex: tabsRouter.activeIndex,
            onDestinationSelected: tabsRouter.setActiveIndex,
            backgroundColor: context.colorScheme.surface,
            indicatorColor: context.colorScheme.primary.withValues(alpha: 0.15),
            destinations: [
              NavigationDestination(
                icon: Assets.icons.other.agentIcon.image(
                  width: CustomWidgetDimensions.navBarIconSize,
                  height: CustomWidgetDimensions.navBarIconSize,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                selectedIcon: Assets.icons.other.agentIcon.image(
                  width: CustomWidgetDimensions.navBarIconSize,
                  height: CustomWidgetDimensions.navBarIconSize,
                  color: context.colorScheme.primary,
                ),
                label: LocaleKeys.nav_agents.tr(),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.map_outlined,
                  color: context.colorScheme.onSurfaceVariant,
                  size: CustomWidgetDimensions.navBarIconSize,
                ),
                selectedIcon: Icon(
                  Icons.map,
                  color: context.colorScheme.primary,
                  size: CustomWidgetDimensions.navBarIconSize,
                ),
                label: LocaleKeys.nav_maps.tr(),
              ),
              NavigationDestination(
                icon: Assets.icons.other.weaponsIcon.image(
                  width: CustomWidgetDimensions.navBarIconSize,
                  height: CustomWidgetDimensions.navBarIconSize,
                  color: context.colorScheme.onSurfaceVariant,
                ),
                selectedIcon: Assets.icons.other.weaponsIcon.image(
                  width: CustomWidgetDimensions.navBarIconSize,
                  height: CustomWidgetDimensions.navBarIconSize,
                  color: context.colorScheme.primary,
                ),
                label: LocaleKeys.nav_weapons.tr(),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.emoji_events_outlined,
                  color: context.colorScheme.onSurfaceVariant,
                  size: CustomWidgetDimensions.navBarIconSize,
                ),
                selectedIcon: Icon(
                  Icons.emoji_events,
                  color: context.colorScheme.primary,
                  size: CustomWidgetDimensions.navBarIconSize,
                ),
                label: LocaleKeys.nav_ranks.tr(),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.settings_outlined,
                  color: context.colorScheme.onSurfaceVariant,
                  size: CustomWidgetDimensions.navBarIconSize,
                ),
                selectedIcon: Icon(
                  Icons.settings,
                  color: context.colorScheme.primary,
                  size: CustomWidgetDimensions.navBarIconSize,
                ),
                label: LocaleKeys.nav_settings.tr(),
              ),
            ],
          ),
        );
      },
    );
  }
}
