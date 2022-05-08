import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:valorant_tips/models/agent.dart';

class ApiClient {
  final Dio dio = Dio();

  final String baseUrl = 'https://valorant-api.com/';
}
