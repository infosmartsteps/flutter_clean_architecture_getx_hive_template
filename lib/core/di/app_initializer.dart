import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../data/adapter/locale_adapter.dart';
import '../data/adapter/log_in_model_adapter.dart';
import '../data/adapter/package_info_model.dart';
import '../data/adapter/theme_mode_adapter.dart';
import '../data/local/i_storage.dart';
import '../data/local/storage_impl.dart';

//lib/core/di/app_initializer.dart
class AppInitializer {
  static Future<void> init() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    // Initialize Hive
    await Hive.initFlutter();
    Hive.registerAdapter(LocaleAdapter());
    Hive.registerAdapter(ThemeModeAdapter());
    Hive.registerAdapter(LogInModelAdapter());
    Hive.registerAdapter(PackageInfoAdapter());

    // Initialize storage
    final storage = StorageImpl();
    await storage.init();
    Get.put<IStorage>(storage, permanent: true);
  }
}
