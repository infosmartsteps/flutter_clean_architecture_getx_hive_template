import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../../config/base_url_config.dart';
import '../../config/flavor_config.dart';
import '../../config/flavor_values.dart';
import '../constants/enums.dart';
import '../controllers/app_controller.dart';
import '../data/adapter/locale_adapter.dart';
import '../data/adapter/log_in_model_adapter.dart';
import '../data/adapter/package_info_model.dart';
import '../data/adapter/theme_mode_adapter.dart';
import '../data/local/i_storage.dart';
import '../data/local/storage_impl.dart';
import '../network/dio_handler.dart';
import '../network/rest_impl.dart';

//lib/core/di/dependency_injection.dart
class DependencyInjection {
  static init() async {
    FlavorConfig(
      flavor: Flavor.development,
      values: FlavorValues(baseUrlEndpoint: BaseUrlConfig.baseUrlProduction),
    );
// Register storage as a singleton
    final storage = StorageImpl();
    Get.put<IStorage>(storage);
    // Initialize Dio - Rest client
    // DioHandlerBinding().dependencies();
    Get.put<DioHandler>(DioHandler(enableLog: kDebugMode), permanent: true);
    // Register IRestClient implementation
    Get.put<RestImpl>(RestImpl(dio: Get.find<DioHandler>().dio));
    // Initialize Hive
    await Hive.initFlutter();
    Hive.registerAdapter(LocaleAdapter());
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(LogInModelAdapter());
    Hive.registerAdapter(PackageInfoAdapter());

    // Initialize storage

    await storage.init();

    //controllers
    Get.put<AppController>(AppController());
  }
}
