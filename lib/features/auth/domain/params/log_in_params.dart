import 'package:get/get.dart';

class LogInParameters {
  final String? username;
  final String? password;
  final int? expiresInMins;

  LogInParameters({this.username, this.password, this.expiresInMins});

  Map<String, dynamic> toJson() => {
        'username': username,
        'password': password,
        'expiresInMins': expiresInMins,
      }..removeWhere((key, value) => value == null || value.isBlank);
}
