import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:get/get.dart';
import 'dart:developer' as developer;

import '../../config/flavor_config.dart';
class DioHandlerBinding extends Bindings {
  @override
  void dependencies() {
    // Controller
    Get.lazyPut<DioHandler>(
          () => DioHandler(enableLog: kDebugMode),
    );
  }
}
//lib/core/network/dio_handler.dart
class DioHandler extends GetxService {
  late Dio dio = Dio();
  final bool enableLog;
  DioHandler({this.enableLog = false});
  @override
  void onInit() {
    super.onInit();

    final Map<String, dynamic> baseHeaders = {
      'Access-Control-Allow-Origin': "*",
      'Content-Type': 'application/json',
      "Access-Control-Allow-Credentials": true,
    };
    dio.options.headers = baseHeaders;
    // Initialize Dio with base options
    dio = Dio(BaseOptions(
      baseUrl: FlavorConfig.instance.values.baseUrlEndpoint,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
    ));

    // Add logger interceptor only in debug mode
    if (Get.isLogEnable) {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: enableLog,
        requestBody: enableLog,
        responseHeader: enableLog,
        responseBody: enableLog,
        error: true,
        logPrint: (logs) => developer.log(logs.toString()),
      ));
    }

    // You can add more interceptors here like:
    // - Authentication interceptor
    // - Error handling interceptor
    // - Retry interceptor
  }
}