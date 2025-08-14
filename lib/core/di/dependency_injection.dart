import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import '../../app.dart';
import '../data/adapter/locale_adapter.dart';
import '../data/adapter/theme_mode_adapter.dart';
import '../data/local/i_storage.dart';
import '../data/local/storage_impl.dart';

//lib/core/di/dependency_injection.dart
class DependencyInjection {
  static init() async {
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
