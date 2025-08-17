import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../../config/base_url_config.dart';
import '../../config/flavor_config.dart';
import '../controllers/theme_mode_controller.dart';
import '../data/adapter/locale_adapter.dart';
import '../data/adapter/theme_mode_adapter.dart';
import '../data/local/i_storage.dart';
import '../data/local/storage_impl.dart';
import '../network/dio_handler.dart';
import '../network/i_rest.dart';
import '../network/rest_impl.dart';

//lib/core/di/dependency_injection.dart
class DependencyInjection {
  static init() async {
    FlavorConfig(
      flavor: Flavor.development,
      values: FlavorValues(baseUrlEndpoint: BaseUrlConfig.baseUrlDevelopment),
    );

    // Initialize Dio - Rest client
    DioHandlerBinding().dependencies();
    // Get.lazyPut(() => DioHandler(enableLog: kDebugMode));
    // Register IRestClient implementation
    Get.lazyPut<IRestClient>(() => RestImpl());
    // Initialize Hive
    await Hive.initFlutter();
    Hive.registerAdapter(LocaleAdapter());
    Hive.registerAdapter(ThemeModeAdapter());

    // Initialize storage
    final storage = StorageImpl();
    await storage.init();

    //controllers
    Get.lazyPut<ThemeModeController>(
      () => ThemeModeController(),
      // fenix: true,
    );

    // Register storage as a singleton
    Get.put<IStorage>(storage);
  }
}
