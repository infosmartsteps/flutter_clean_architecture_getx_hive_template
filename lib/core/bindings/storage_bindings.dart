import 'package:get/get.dart';
import '../data/local/data/datasources/local_storage_data_source.dart';
import '../data/local/domain/repositories/local_storage_repository.dart';

class StorageBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStorageDataSource>(
          () => LocalStorageDataSourceImpl(),
      fenix: true,
    );
    Get.lazyPut<LocalStorageRepository>(
          () => LocalStorageRepositoryImpl(Get.find<LocalStorageDataSource>()),
      fenix: true,
    );
  }
}

