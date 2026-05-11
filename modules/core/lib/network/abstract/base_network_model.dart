import 'package:dio/dio.dart';

abstract class BaseNetworkModel {
  const BaseNetworkModel(this.dio);
  final Dio dio;
}
