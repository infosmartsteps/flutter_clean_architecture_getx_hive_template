import 'package:dio/dio.dart';
import 'models/response_model.dart';

//lib/core/network/handle_dio_error.dart
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