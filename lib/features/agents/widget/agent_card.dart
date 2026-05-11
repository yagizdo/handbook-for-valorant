import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/features/agents/constants/agent_color_constants.dart';
import 'package:handbook_for_valorant/features/agents/model/agent_model.dart';
import 'package:handbook_for_valorant/product/router/app_router.gr.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:theme_module/theme_module.dart';

class AgentCard extends StatelessWidget {
  const AgentCard({required this.agent, super.key});
  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    final colors =
        AgentColorConstants.agentColors[agent.displayName.toLowerCase()] ??
        [context.colorScheme.error, context.colorScheme.scrim];
    final accentColor = colors.first;

    return GestureDetector(
      onTap: () => context.router.push(AgentDetailRoute(agent: agent)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(Dimensions.cardBorderRadius),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.2,
              colors: [accentColor.withValues(alpha: 0.3), context.colorScheme.surface],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Agent portrait
              Positioned(
                top: CustomWidgetDimensions.agentCardPortraitTopOffset,
                left: 0,
                right: 0,
                bottom: 0,
                child: ProductImage.network(
                  // TODO : Fix null path in every feature
                  path: agent.fullPortrait ?? '',
                  errorWidget: Icon(Icons.error, color: context.colorScheme.onSurface.withValues(alpha: 0.24)),
                ),
              ),

              // Agent-specific color accent at bottom
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: CustomWidgetDimensions.agentCardAccentLineHeight,
                child: Container(
                  decoration: BoxDecoration(gradient: LinearGradient(colors: colors.take(2).toList())),
                ),
              ),

              // Bottom gradient overlay for text readability
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                height: CustomWidgetDimensions.agentCardBottomGradientHeight,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        context.colorScheme.scrim.withValues(alpha: 0),
                        context.colorScheme.scrim.withValues(alpha: context.isDarkMode ? 0.6 : 0.7),
                      ],
                    ),
                  ),
                ),
              ),

              // Agent info
              Positioned(
                bottom: Dimensions.k12,
                left: Dimensions.k12,
                right: Dimensions.k12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      agent.displayName,
                      style: context.textTheme.headlineSmall?.copyWith(
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Gaps.g4,
                    _AgentRoleLabel(
                      roleName: agent.role?.displayName ?? '',
                      accentColor: accentColor,
                      roleIconUrl: agent.role?.displayIcon,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AgentRoleLabel extends StatelessWidget {
  const _AgentRoleLabel({required this.roleName, required this.accentColor, this.roleIconUrl});
  final String roleName;
  final Color accentColor;
  final String? roleIconUrl;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? context.colorScheme.primary.withValues(alpha: 0.35)
            : context.colorScheme.primary.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(Dimensions.k6),
        border: Border.all(
          color: accentColor.withValues(alpha: context.isDarkMode ? 0.5 : 0.7),
          width: CustomWidgetDimensions.agentCardRoleBorderWidth,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k8, vertical: Dimensions.k4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (roleIconUrl != null) ...[
              ProductImage.network(
                path: roleIconUrl!,
                width: CustomWidgetDimensions.agentCardRoleInfoIconSize,
                height: CustomWidgetDimensions.agentCardRoleInfoIconSize,
                fit: BoxFit.contain,
                showError: false,
              ),
              Gaps.g4,
            ],
            Flexible(
              child: Text(
                roleName.toUpperCase(),
                style: context.textTheme.labelSmall?.copyWith(
                  color: context.colorScheme.onPrimary.withValues(alpha: 0.95),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
