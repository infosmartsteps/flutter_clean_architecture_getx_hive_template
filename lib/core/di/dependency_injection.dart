import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/network/i_rest.dart';
import '../../config/base_url_config.dart';
import '../../config/flavor_config.dart';
import '../../config/flavor_values.dart';
import '../constants/enums.dart';
import '../controllers/app_controller.dart';
import '../network/dio_handler.dart';
import '../network/rest_impl.dart';

//lib/core/di/dependency_injection.dart
class DependencyInjection {
  static init() {
    FlavorConfig(
      flavor: Flavor.development,
      values: FlavorValues(baseUrlEndpoint: BaseUrlConfig.baseUrlProduction),
    );

    // DioHandlerBinding().dependencies();
    Get.put<DioHandler>(DioHandler(enableLog: kDebugMode), permanent: true);

    // Register IRestClient implementation
    Get.put<IRestClient>(RestImpl(dio: Get.find<DioHandler>().dio));

    //controllers
    Get.put<AppController>(AppController());
  }
}
