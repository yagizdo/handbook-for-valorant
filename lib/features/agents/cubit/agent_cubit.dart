import 'package:core/logger/product_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gen/gen.dart';
import 'package:handbook_for_valorant/features/agents/cubit/agent_state.dart';
import 'package:handbook_for_valorant/features/agents/model/agents_request_model.dart';
import 'package:handbook_for_valorant/features/agents/model/agents_success_model.dart';
import 'package:handbook_for_valorant/features/agents/service/agent_service.dart';
import 'package:handbook_for_valorant/product/constants/app_constants.dart';
import 'package:handbook_for_valorant/product/locator/base_cubit.dart';

class AgentCubit extends Cubit<AgentState> with BaseCubit<AgentState> {
  AgentCubit({required AgentService agentService}) : _agentService = agentService, super(const AgentState.initial());
  final AgentService _agentService;

  void filterByRole(int index) {
    final currentState = state;
    if (currentState is! AgentStateSuccess) return;
    if (index < 0 || index > currentState.data.uniqueRoles.length) return;

    emit(AgentState.success(currentState.data.copyWith(selectedFilterIndex: index)));
  }

  Future<void> loadAgents() async {
    emit(const AgentState.loading());

    try {
      const agentsRequestModel = AgentsRequestModel(isPlayableCharacter: true);
      final agents = await _agentService.getAgents(agentsRequestModel: agentsRequestModel);

      if (agents.isEmpty) {
        safeEmit(const AgentState.empty());
        return;
      }

      safeEmit(AgentState.success(AgentsSuccessModel(allAgents: agents)));
    } on Exception catch (e) {
      ProductLogger.e(e.toString(), tag: AppConstants.agentCubitLogTag);
      // TODO: Fix here and check other cubits too. Users no need to see original error message.
      // But first check which error messages cames here
      safeEmit(AgentState.error(LocaleKeys.agents_empty.tr()));
    }
  }
}
