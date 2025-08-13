import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../config/flavor_config.dart';

class NetworkBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() {
      final dio = Dio(BaseOptions(
        baseUrl: FlavorConfig.instance.values.baseUrlEndpoint,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
      ));

      // Add interceptors
      dio.interceptors.add(LogInterceptor(
        request: true,
        responseBody: true,
        requestBody: true,
      ));

      return dio;
    }, fenix: true);
  }
}