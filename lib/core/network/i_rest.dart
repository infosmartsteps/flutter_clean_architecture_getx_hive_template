import 'package:flutter/foundation.dart';
import 'models/response_model.dart';

//lib/core/network/i_rest.dart
abstract class IRestClient {
  Future<ApiResponse> get(
      String path, {
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
      });

  Future<ApiResponse> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
      });

  Future<ApiResponse> put(
      String path, {
        dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
      });

  Future<ApiResponse> patch(
      String path, {
        dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
      });

  Future<ApiResponse> delete(
      String path, {
        dynamic data,
        Map<String, dynamic>? headers,
        Map<String, dynamic>? queryParameters,
      });
}