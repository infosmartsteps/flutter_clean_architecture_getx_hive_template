//lib/core/network/models/response_model.dart
class ApiResponse {
  final dynamic data;
  final bool success;
  final String? message;
  final int? statusCode;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json["success"] ?? true,
      message: json["message"],
      data: json["data"],
      statusCode: json["statusCode"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
        "statusCode": statusCode,
      };
}
