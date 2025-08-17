class ApiResponse {
  final dynamic data;
  final bool success;
  final String? message;
  final int? statusCode;
  final String? accessToken;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.statusCode,
    this.accessToken,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      success: json["success"] ?? false,
      message: json["message"],
      data: json["data"],
      statusCode: json["statusCode"],
      accessToken: json["accessToken"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
        "statusCode": statusCode,
        "accessToken": accessToken,
      };
}
