import 'package:core/constants/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/agents/cubit/agent_cubit.dart';
import 'package:handbook_for_valorant/features/agents/cubit/agent_state.dart';
import 'package:handbook_for_valorant/features/agents/model/agents_success_model.dart';
import 'package:handbook_for_valorant/features/agents/widget/agent_filter_item.dart';

class AgentFiltersList extends StatelessWidget {
  const AgentFiltersList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: CustomWidgetDimensions.agentFiltersListHeight,
      child: BlocBuilder<AgentCubit, AgentState>(
        buildWhen: (prev, curr) {
          if (curr is! AgentStateSuccess) return false;
          if (prev is! AgentStateSuccess) return true;
          return prev.data.selectedFilterIndex != curr.data.selectedFilterIndex;
        },
        builder: (context, state) {
          if (state is! AgentStateSuccess) return const SizedBox.shrink();
          final roles = state.data.uniqueRoles;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: roles.length + 1,
            itemBuilder: (context, index) {
              final label = index == 0 ? LocaleKeys.common_filter_all.tr() : roles[index - 1].displayName;
              return AgentFilterItem(
                index: index,
                label: label,
                isSelected: state.data.selectedFilterIndex == index,
                onTap: () => context.read<AgentCubit>().filterByRole(index),
              );
            },
          );
        },
      ),
    );
  }
}
