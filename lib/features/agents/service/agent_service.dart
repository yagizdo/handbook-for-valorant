import 'package:handbook_for_valorant/features/agents/model/agent_model.dart';
import 'package:handbook_for_valorant/features/agents/model/agents_request_model.dart';
import 'package:handbook_for_valorant/features/agents/model/agents_response_model.dart';
import 'package:handbook_for_valorant/product/constants/api_endpoints.dart';
import 'package:handbook_for_valorant/product/network/product_network_model.dart';

class AgentService {
  AgentService({required ProductNetworkModel networkModel}) : _networkModel = networkModel;
  final ProductNetworkModel _networkModel;

  Future<List<AgentModel>> getAgents({required AgentsRequestModel agentsRequestModel}) async {
    final result = await _networkModel.get<Map<String, dynamic>>(
      ApiEndpoints.agents,
      queryParameters: agentsRequestModel.toJson(),
    );

    return result.fold(
      onError: (error) => [],
      onSuccess: (data) {
        if (data == null) return [];
        final agentsResponseModel = AgentsResponseModel.fromJson(data);
        if (agentsResponseModel.agents == null) return [];
        return agentsResponseModel.agents!;
      },
    );
  }
}
