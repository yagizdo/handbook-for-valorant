import 'package:core/constants/durations.dart';
import 'package:core/logger/product_logger.dart';
import 'package:core/network/concrete/network_model_impl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:handbook_for_valorant/product/constants/api_endpoints.dart';

final class ProductNetworkModel extends NetworkModel {
  ProductNetworkModel() : super(Dio(BaseOptions(baseUrl: ApiEndpoints.baseUrl, connectTimeout: AppDurations.s30))) {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['language'] = language;
          handler.next(options);
        },
      ),
      if (kDebugMode)
        LogInterceptor(
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          logPrint: (object) => ProductLogger.d(object.toString(), tag: 'NetworkModel'),
        ),
    ]);
  }

  String language = 'en-US';
}
