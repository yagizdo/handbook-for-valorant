import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorant_tips/models/agent.dart';

class ApiClient {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://valorant-api.com/';

  Future<Iterable<Agent>> getAgents() async {
    Iterable<Agent> agents = [];

    try {
      Response response = await _dio.get("${_baseUrl}v1/agents");

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
