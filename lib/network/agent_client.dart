import 'package:dio/dio.dart';
import 'package:valorant_tips/network/api_client.dart';

import '../models/agent.dart';

class AgentClient extends ApiClient {
  Future<Iterable<Agent>> getAgents() async {
    Iterable<Agent> agents = [];
    try {
      Response response = await super.dio.get("${super.baseUrl}v1/agents");

      List parsedList = response.data['data'];
      agents = parsedList.map((element) {
        return Agent.fromJson(element);
      });

    } on DioError catch (e) {
      if (e.response != null) {
        print('STATUS: ${e.response?.statusCode}');
        print('DATA: ${e.response?.data}');
        print('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        print('Error sending request!');
        print(e.message);
      }
    }
    return agents;
  }
}