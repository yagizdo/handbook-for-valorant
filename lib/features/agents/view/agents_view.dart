import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:core/constants/dimensions.dart';
import 'package:core/constants/gaps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/agents/cubit/agent_cubit.dart';
import 'package:handbook_for_valorant/features/agents/cubit/agent_state.dart';
import 'package:handbook_for_valorant/features/agents/model/agent_model.dart';
import 'package:handbook_for_valorant/features/agents/model/agents_success_model.dart';
import 'package:handbook_for_valorant/features/agents/widget/agent_card.dart';
import 'package:handbook_for_valorant/features/agents/widget/agent_filters_list.dart';
import 'package:handbook_for_valorant/product/widgets/product_error.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:theme_module/theme_module.dart';

@RoutePage()
class AgentsView extends StatefulWidget {
  const AgentsView({super.key});

  @override
  State<AgentsView> createState() => _AgentsViewState();
}

class _AgentsViewState extends State<AgentsView> {
  @override
  void initState() {
    super.initState();
    unawaited(context.read<AgentCubit>().loadAgents());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimensions.k16, Dimensions.k20, Dimensions.k16, Dimensions.k4),
            child: Text(LocaleKeys.agents_title.tr(), style: context.textTheme.headlineLarge),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: Dimensions.k12),
            child: AgentFiltersList(),
          ),
          Gaps.g12,
          const Expanded(child: _AgentsContent()),
        ],
      ),
    );
  }
}

class _AgentsContent extends StatelessWidget {
  const _AgentsContent();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AgentCubit, AgentState>(
      builder: (context, state) {
        return switch (state) {
          AgentStateInitial() => const SizedBox.shrink(),
          AgentStateEmpty() => const _EmptyAgentsList(),
          AgentStateLoading() => const _SkeletonAgentsList(),
          AgentStateSuccess(:final data) => _AgentsList(agents: data.agents),
          AgentStateError(:final errorMessage) => ProductError(
            message: errorMessage,
            onRetry: () => context.read<AgentCubit>().loadAgents(),
          ),
        };
      },
    );
  }
}

// TODO: Create a product empty widget or at least good empty widget
class _EmptyAgentsList extends StatelessWidget {
  const _EmptyAgentsList();

  @override
  Widget build(BuildContext context) {
    return Center(child: Text(LocaleKeys.agents_empty.tr()));
  }
}

class _SkeletonAgentsList extends StatelessWidget {
  const _SkeletonAgentsList();

  // TODO: Improve mock data generation
  List<AgentModel> get _fakePlaceholderAgents => List.generate(
    6,
    (index) => AgentModel(
      uuid: 'placeholder-$index',
      displayName: 'Agent Name',
      description: 'Agent description placeholder text',
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: CustomWidgetDimensions.agentCardAspectRatio,
          crossAxisSpacing: Dimensions.k12,
          mainAxisSpacing: Dimensions.k12,
        ),
        itemCount: _fakePlaceholderAgents.length,
        itemBuilder: (context, index) {
          return AgentCard(agent: _fakePlaceholderAgents[index]);
        },
      ),
    );
  }
}

class _AgentsList extends StatelessWidget {
  const _AgentsList({required this.agents});
  final List<AgentModel> agents;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => context.read<AgentCubit>().loadAgents(),
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.k12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: CustomWidgetDimensions.agentCardAspectRatio,
          crossAxisSpacing: Dimensions.k12,
          mainAxisSpacing: Dimensions.k12,
        ),
        itemCount: agents.length,
        itemBuilder: (context, index) {
          return AgentCard(agent: agents[index]);
        },
      ),
    );
  }
}
