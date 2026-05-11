import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/agents/model/agent_model.dart';

part 'agents_response_model.freezed.dart';
part 'agents_response_model.g.dart';

@freezed
abstract class AgentsResponseModel with _$AgentsResponseModel {
  const factory AgentsResponseModel({@JsonKey(name: 'data') List<AgentModel>? agents}) = _AgentsResponseModel;

  factory AgentsResponseModel.fromJson(Map<String, dynamic> json) => _$AgentsResponseModelFromJson(json);
}
