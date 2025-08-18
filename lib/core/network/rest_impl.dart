import 'package:dio/dio.dart';
import '../data/local/storage_helper.dart';
import 'i_rest.dart';
import 'models/request_model.dart';
import 'models/response_model.dart';

//lib/core/network/rest_impl.dart
class RestImpl implements IRestClient {
  final Dio dio;

  RestImpl({required this.dio});

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

      final response = await dio.delete(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
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

      final response = await dio.get(
        path,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
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

      final response = await dio.patch(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
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

      final response = await dio.post(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

//delete
      final Response res =
          Response(requestOptions: response.requestOptions, data: {
        "success": true,
        "message": "success",
        "data": response.data,
        "statusCode": 201,
      });
      //to here stop

      // ApiResponse res = _handleResponse(response);
      // return res;
      return _handleResponse(res);
    } on DioException catch (e) {
      return handleDioError(e);
    } catch (e) {
      print(e);
      return ApiResponse(success: false);
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

      final response = await dio.put(
        path,
        data: requestData.data,
        options: Options(headers: requestData.headers),
        queryParameters: requestData.params,
      );

      return _handleResponse(response);
    } on DioException catch (e) {
      return handleDioError(e);
    }
  }

  Future<RequestData> _prepareRequest({
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async {
    final requestHeaders = Map<String, dynamic>.from(dio.options.headers);

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
}

// Error handling function
ApiResponse handleDioError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return ApiResponse(
        message: error.response?.data["message"] ?? 'Request timeout',
        statusCode: error.response?.statusCode ?? 408,
        success: false,
      );
    case DioExceptionType.badResponse:
      return ApiResponse(
        message: error.response?.data["message"] ??
            'Server error: ${error.response?.statusCode} - ${error.response?.statusMessage}',
        statusCode: error.response?.statusCode ?? 500,
        success: false,
      );
    case DioExceptionType.cancel:
      return ApiResponse(
        message: error.response?.data["message"] ?? 'Request cancelled by user',
        statusCode: error.response?.statusCode ?? 499,
        success: false,
      );
    case DioExceptionType.connectionError:
      return ApiResponse(
        message: 'No internet connection available',
        statusCode: error.response?.statusCode ?? 503,
        success: false,
      );
    case DioExceptionType.badCertificate:
      return ApiResponse(
        message: error.response?.data["message"] ?? 'SSL certificate error',
        statusCode: error.response?.statusCode ?? 495,
        success: false,
      );
    case DioExceptionType.unknown:
      return ApiResponse(
        message: error.response?.data["message"] ??
            'Unknown network error: ${error.message}',
        statusCode: error.response?.statusCode ?? 520,
        success: false,
      );
  }
}
