import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/agents/model/agent_model.dart';
import 'package:handbook_for_valorant/features/agents/model/role_model.dart';

part 'agents_success_model.freezed.dart';

@freezed
abstract class AgentsSuccessModel with _$AgentsSuccessModel {
  const factory AgentsSuccessModel({required List<AgentModel> allAgents, @Default(0) int selectedFilterIndex}) =
      _AgentsSuccessModel;
  const AgentsSuccessModel._();
}

extension AgentsSuccessModelExt on AgentsSuccessModel {
  List<RoleModel> get uniqueRoles {
    final seen = <String>{};
    final roles = <RoleModel>[];
    for (final agent in allAgents) {
      final role = agent.role;
      if (role != null && seen.add(role.uuid)) {
        roles.add(role);
      }
    }
    return roles;
  }

  List<AgentModel> get agents {
    if (selectedFilterIndex == 0) return allAgents;
    final roles = uniqueRoles;
    if (selectedFilterIndex - 1 >= roles.length) return allAgents;
    final selectedRole = roles[selectedFilterIndex - 1];
    return allAgents.where((agent) => agent.role?.uuid == selectedRole.uuid).toList();
  }
}
