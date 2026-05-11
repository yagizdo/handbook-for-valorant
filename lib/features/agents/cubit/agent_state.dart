import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:handbook_for_valorant/features/agents/model/agents_success_model.dart';

part 'agent_state.freezed.dart';

@freezed
sealed class AgentState with _$AgentState {
  const factory AgentState.error(String errorMessage) = AgentStateError;
  const factory AgentState.empty() = AgentStateEmpty;
  const factory AgentState.initial() = AgentStateInitial;
  const factory AgentState.loading() = AgentStateLoading;
  const factory AgentState.success(AgentsSuccessModel data) = AgentStateSuccess;
}
