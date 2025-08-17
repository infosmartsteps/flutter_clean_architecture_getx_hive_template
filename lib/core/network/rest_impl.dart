import 'package:dio/dio.dart';
import 'package:ksa_real_estates/core/network/i_rest.dart';
import 'package:ksa_real_estates/core/network/models/response_model.dart';

import '../data/local/storage_helper.dart';
import 'dio_handler.dart';
import 'models/request_model.dart';

//lib/core/network/rest_impl.dart
class RestImpl implements IRestClient {
  final Dio _dio = DioHandler().dio;

  @override
  Future<ApiResponse> delete(String path,
      {data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final requestData = await _prepareRequest(
        data: data,
        queryParameters: queryParameters,
      );

      final response = await _dio.delete(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> get(String path,
      {Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final requestData = await _prepareRequest(
        queryParameters: queryParameters,
      );

      final response = await _dio.get(
        path,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> patch(String path,
      {data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final requestData = await _prepareRequest(
        data: data,
        queryParameters: queryParameters,
      );

      final response = await _dio.patch(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final requestData = await _prepareRequest(
        data: data,
        queryParameters: queryParameters,
      );

      final response = await _dio.post(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  @override
  Future<ApiResponse> put(String path,
      {data,
      Map<String, dynamic>? headers,
      Map<String, dynamic>? queryParameters}) async {
    try {
      final requestData = await _prepareRequest(
        data: data,
        queryParameters: queryParameters,
      );

      final response = await _dio.put(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    }
  }

  Future<RequestData> _prepareRequest({
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final requestHeaders = Map<String, dynamic>.from(_dio.options.headers);

    // Add common headers
    requestHeaders.addAll({
      'lang': await StorageHelper().getAppLang(),
      'DeviceDate': DateTime.now().toIso8601String(),
    });

    // Add authorization header if token exists
    final token = await StorageHelper().getAuthTokenKey();
    if (token != null && token.isNotEmpty) {
      requestHeaders['Authorization'] = 'Bearer $token';
    }

    return RequestData(
      data: data,
      headers: requestHeaders,
      params: queryParameters ?? {},
    );
  }

  ApiResponse _handleResponse(Response response) {
    if (response.data is Map) {
      return ApiResponse.fromJson(response.data);
    }

    return ApiResponse(
      success: response.statusCode! >= 200 && response.statusCode! < 300,
      statusCode: response.statusCode ?? 999,
      data: response.data,
      message: response.statusMessage ?? '',
    );
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw ApiResponse(
            message: 'Request timeout',
            statusCode: error.response?.statusCode ?? 999,
            success: false);
      case DioExceptionType.badResponse:
        throw ApiResponse(
            message: 'Server error: ${error.response?.statusCode}',
            statusCode: error.response?.statusCode ?? 999,
            success: false);
      case DioExceptionType.cancel:
        throw ApiResponse(
            message: 'Request cancelled',
            statusCode: error.response?.statusCode ?? 999,
            success: false);
      case DioExceptionType.unknown:
        throw ApiResponse(
            message: 'No internet connection',
            statusCode: error.response?.statusCode ?? 999,
            success: false);
      default:
        throw ApiResponse(
            message: 'Something went wrong',
            statusCode: error.response?.statusCode ?? 999,
            success: false);
    }
  }
}
