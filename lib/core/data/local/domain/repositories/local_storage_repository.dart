
import '../../data/datasources/hive_box_manager.dart';
import '../../data/datasources/local_storage_data_source.dart';
import '../../domain/repositories/local_storage_repository.dart';

// lib/core/data/local/domain/repositories/local_storage_repository.dart
abstract class LocalStorageRepository {
  Future<void> init();

  Future<void> save<T>(String boxName, dynamic key, T value);

  Future<T?> get<T>(String boxName, dynamic key);

  Future<void> delete(String boxName, dynamic key);

  Future<void> clearBox(String boxName);

  Future<bool> containsKey(String boxName, dynamic key);

  Future<List<dynamic>> getAllKeys(String boxName);

  Future<void> closeBox(String boxName);

  Future<void> clearAllData();
}

class LocalStorageRepositoryImpl implements LocalStorageRepository {
  final LocalStorageDataSource _dataSource;

  LocalStorageRepositoryImpl(this._dataSource);

  @override
  Future<void> init() async => await _dataSource.init();

  @override
  Future<void> save<T>(String boxName, dynamic key, T value) async {
    await _dataSource.save<T>(boxName, key, value);
  }

  @override
  Future<T?> get<T>(String boxName, dynamic key) async {
    return await _dataSource.get<T>(boxName, key);
  }

  @override
  Future<void> delete(String boxName, dynamic key) async {
    await _dataSource.delete(boxName, key);
  }

  @override
  Future<void> clearBox(String boxName) async {
    await _dataSource.clearBox(boxName);
  }

  @override
  Future<bool> containsKey(String boxName, dynamic key) async {
    return await _dataSource.containsKey(boxName, key);
  }

  @override
  Future<List<dynamic>> getAllKeys(String boxName) async {
    return await _dataSource.getAllKeys(boxName);
  }

  @override
  Future<void> closeBox(String boxName) async {
    await _dataSource.closeBox(boxName);
  }

  @override
  Future<void> clearAllData() async {
    await HiveBoxManager.clearAllData();
  }
}

// class AuthController extends GetxController {
//   final LoginUseCase _loginUseCase = Get.find();
//   final LocalStorageRepository _storage = Get.find(tag: 'localStorage');
//
//   Future<void> login(String email, String password) async {
//     final result = await _loginUseCase.execute(LoginParams(email, password));
//     // Handle result
//   }
// }