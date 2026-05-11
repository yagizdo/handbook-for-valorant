import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/agents/model/ability_model.dart';
import 'package:handbook_for_valorant/features/agents/model/role_model.dart';

part 'agent_model.freezed.dart';
part 'agent_model.g.dart';

@freezed
abstract class AgentModel with _$AgentModel {
  const factory AgentModel({
    required String uuid,
    required String displayName,
    String? description,
    String? displayIcon,
    String? fullPortrait,
    bool? isPlayableCharacter,
    RoleModel? role,
    @Default([]) List<AbilityModel> abilities,
  }) = _AgentModel;

  factory AgentModel.fromJson(Map<String, dynamic> json) => _$AgentModelFromJson(json);
}
