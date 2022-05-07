import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorant_tips/models/agents.dart';

class ApiClient{
Dio _dio = Dio();

final String _baseUrl = 'https://valorant-api.com/';

Future<Agents> getAgents() async {
  Response agentData = await _dio.get(_baseUrl + 'v1/agents/');


  Agents agents = Agents.fromJson(agentData.data);

  print('User info : ${agents.data.displayName}');
  print('User info : ${agents.data.role}');

  return agents;
}
}
