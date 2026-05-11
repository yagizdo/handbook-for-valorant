import 'package:core/constants/network_error_messages.dart';
import 'package:core/network/abstract/base_network_model.dart';
import 'package:core/network/model/network_result_model.dart';
import 'package:dio/dio.dart';

class NetworkModel extends BaseNetworkModel {
  NetworkModel(super.dio);

  /// Sends a GET request to the specified [path].
  /// Returns [NetworkResult<T>] containing the response data or an error.
  Future<NetworkResult<T>> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final result = await dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (result.data is! T) throw Exception(NetworkErrorMessages.invalidDataType);
      return NetworkResult.success(result.data as T);
    } on DioException catch (e) {
      return NetworkResult.error(
        message: e.message ?? NetworkErrorMessages.defaultError,
        code: e.response?.statusCode ?? 0,
      );
    } on Exception catch (e) {
      return NetworkResult.error(message: e.toString());
    }
  }

  /// Sends a POST request to the specified [path] with optional [data].
  /// Returns [NetworkResult<T>] containing the response data or an error.
  Future<NetworkResult<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final result = await dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (result.data is! T) throw Exception(NetworkErrorMessages.invalidDataType);
      return NetworkResult.success(result.data as T);
    } on DioException catch (e) {
      return NetworkResult.error(
        message: e.message ?? NetworkErrorMessages.defaultError,
        code: e.response?.statusCode ?? 0,
      );
    } on Exception catch (e) {
      return NetworkResult.error(message: e.toString());
    }
  }

  /// Sends a PUT request to the specified [path] with optional [data].
  /// Returns [NetworkResult<T>] containing the response data or an error.
  Future<NetworkResult<T>> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
  }) async {
    try {
      final result = await dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      if (result.data is! T) throw Exception(NetworkErrorMessages.invalidDataType);
      return NetworkResult.success(result.data as T);
    } on DioException catch (e) {
      return NetworkResult.error(
        message: e.message ?? NetworkErrorMessages.defaultError,
        code: e.response?.statusCode ?? 0,
      );
    } on Exception catch (e) {
      return NetworkResult.error(message: e.toString());
    }
  }

  /// Sends a DELETE request to the specified [path].
  /// Returns [NetworkResult<T>] containing the response data or an error.
  Future<NetworkResult<T>> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      final result = await dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
      if (result.data is! T) throw Exception(NetworkErrorMessages.invalidDataType);
      return NetworkResult.success(result.data as T);
    } on DioException catch (e) {
      return NetworkResult.error(
        message: e.message ?? NetworkErrorMessages.defaultError,
        code: e.response?.statusCode ?? 0,
      );
    } on Exception catch (e) {
      return NetworkResult.error(message: e.toString());
    }
  }
}
