import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:core/utility/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/agents/constants/agent_color_constants.dart';
import 'package:handbook_for_valorant/features/agents/model/agent_model.dart';
import 'package:handbook_for_valorant/product/widgets/image/product_image.dart';
import 'package:theme_module/theme_module.dart';

class AgentInfo extends StatelessWidget {
  const AgentInfo({required this.agent, super.key});
  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _AgentImage(agent: agent),
        _AgentBio(agent: agent),
      ],
    );
  }
}

class _AgentImage extends StatelessWidget {
  const _AgentImage({required this.agent});
  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // Agent portrait
          SizedBox(
            width: context.width,
            child: ProductImage.network(
              // TODO : Fix null path in every feature
              path: agent.fullPortrait ?? '',
              width: context.width,
              fit: BoxFit.contain,
            ),
          ),

          // Gradient fade at bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: CustomWidgetDimensions.agentImageGradientHeight,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    context.colorScheme.surface.withValues(alpha: 0),
                    context.colorScheme.surface.withValues(alpha: 0.8),
                    context.colorScheme.surface,
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
          ),

          // Agent name and role
          Positioned(
            bottom: Dimensions.k8,
            left: Dimensions.k24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  agent.displayName,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w900,
                    shadows: [Shadow(color: context.colorScheme.shadow.withValues(alpha: 0.5), blurRadius: 6)],
                  ),
                ),
                Gaps.g4,
                Row(
                  children: [
                    if (agent.role?.displayIcon != null)
                      ProductImage.network(
                        path: agent.role!.displayIcon!,
                        width: CustomWidgetDimensions.agentRoleIconSize,
                        height: CustomWidgetDimensions.agentRoleIconSize,
                      ),
                    Gaps.g6,
                    Text(
                      agent.role?.displayName ?? LocaleKeys.agents_noRoleData.tr(),
                      style: context.textTheme.labelSmall?.copyWith(
                        color: context.colorScheme.onSurface.withValues(alpha: 0.7),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AgentBio extends StatelessWidget {
  const _AgentBio({required this.agent});
  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    final colors =
        AgentColorConstants.agentColors[agent.displayName.toLowerCase()] ??
        [context.colorScheme.error, context.colorScheme.scrim];

    return Padding(
      padding: const EdgeInsets.only(top: Dimensions.k24, left: Dimensions.k24, right: Dimensions.k24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: CustomWidgetDimensions.bioIndicatorWidth,
                height: CustomWidgetDimensions.bioIndicatorHeight,
                decoration: BoxDecoration(color: colors.first, borderRadius: BorderRadius.circular(Dimensions.k2)),
              ),
              Gaps.g8,
              Text(
                LocaleKeys.agents_section_biography.tr().toUpperCase(),
                style: context.textTheme.labelMedium?.copyWith(
                  color: context.colorScheme.onSurface.withValues(alpha: 0.5),
                  letterSpacing: 2,
                ),
              ),
            ],
          ),
          Gaps.g12,
          Text(
            agent.description ?? '',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurface.withValues(alpha: 0.85),
              height: 1.5,
            ),
            maxLines: CustomWidgetDimensions.bioDescriptionMaxLines,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
