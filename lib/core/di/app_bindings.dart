import 'package:get/get.dart';
import 'package:ksa_real_estates/core/bindings/lang_binding.dart';
import '../data/local/data/datasources/hive_box_manager.dart';
import '../bindings/network_bindings.dart';
import '../bindings/repository_bindings.dart';
import '../bindings/storage_bindings.dart';
import '../bindings/usecase_bindings.dart';

//lib/core/di/app_bindings.dart
class AppBindings implements Bindings {
  @override
  @override
  Future<void> dependencies() async {
    // Initialize Hive and register adapters
    await HiveBoxManager.init();
    LangBinding().dependencies();
    StorageBindings().dependencies();
    NetworkBindings().dependencies();
    RepositoryBindings().dependencies();
    UseCaseBindings().dependencies();
  }
}
