import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:core/utility/extension/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:handbook_for_valorant/features/agents/constants/agent_color_constants.dart';
import 'package:handbook_for_valorant/features/agents/model/agent_model.dart';
import 'package:handbook_for_valorant/features/agents/widget/ability_section.dart';
import 'package:handbook_for_valorant/features/agents/widget/agent_info.dart';
import 'package:handbook_for_valorant/product/widgets/buttons/product_back_button_overlay.dart';
import 'package:handbook_for_valorant/product/widgets/product_scaffold.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class AgentDetailView extends StatelessWidget {
  const AgentDetailView({required this.agent, super.key});

  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    return ProductScaffold(body: _AgentDetailContent(agent: agent));
  }
}

class _AgentDetailContent extends StatelessWidget {
  const _AgentDetailContent({required this.agent});

  final AgentModel agent;

  @override
  Widget build(BuildContext context) {
    final colors =
        AgentColorConstants.agentColors[agent.displayName.toLowerCase()] ??
        [context.colorScheme.error, context.colorScheme.scrim];
    return Stack(
      children: [
        // Subtle agent-colored gradient background
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: context.height * 0.5,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [colors.first.withValues(alpha: 0.3), context.colorScheme.surface],
              ),
            ),
          ),
        ),
        _AbilitySection(agent: agent, colors: colors),
        const ProductBackButtonOverlay(),
      ],
    );
  }
}

class _AbilitySection extends StatelessWidget {
  const _AbilitySection({required this.agent, required this.colors});

  final AgentModel agent;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gaps.custom(MediaQuery.of(context).padding.top + Dimensions.k10),
          AgentInfo(agent: agent),
          Padding(
            padding: const EdgeInsets.only(left: Dimensions.k16),
            child: AbilitySection(abilities: agent.abilities, agentColors: colors),
          ),
          Gaps.g32,
        ],
      ),
    );
  }
}
