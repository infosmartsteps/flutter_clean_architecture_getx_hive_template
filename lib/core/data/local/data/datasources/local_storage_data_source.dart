import 'package:hive/hive.dart';

import 'hive_box_manager.dart';

// lib/core/data/local/data/datasources/local_storage_data_source.dart
abstract class LocalStorageDataSource {
  Future<void> init();

  Future<void> save<T>(String boxName, dynamic key, T value);

  Future<T?> get<T>(String boxName, dynamic key);

  Future<void> delete(String boxName, dynamic key);

  Future<void> clearBox(String boxName);

  Future<bool> containsKey(String boxName, dynamic key);

  Future<List<dynamic>> getAllKeys(String boxName);

  Future<void> closeBox(String boxName);

  Future<void> saveAll<T>(String boxName, Map<dynamic, T> values);

  Future<Map<dynamic, T>> getAll<T>(String boxName);
}

class LocalStorageDataSourceImpl implements LocalStorageDataSource {
  @override
  Future<void> init() async => await HiveBoxManager.init();

  Future<Box<T>> _getBox<T>(String boxName) async {
    return await HiveBoxManager.openBox<T>(boxName);
  }

  @override
  Future<void> save<T>(String boxName, dynamic key, T value) async {
    final box = await _getBox<T>(boxName);
    await box.put(key, value);
  }

  @override
  Future<T?> get<T>(String boxName, dynamic key) async {
    final box = await _getBox<T>(boxName);
    return box.get(key);
  }

  @override
  Future<void> delete(String boxName, dynamic key) async {
    final box = await _getBox(boxName);
    await box.delete(key);
  }

  @override
  Future<void> clearBox(String boxName) async {
    final box = await _getBox(boxName);
    await box.clear();
  }

  @override
  Future<bool> containsKey(String boxName, dynamic key) async {
    final box = await _getBox(boxName);
    return box.containsKey(key);
  }

  @override
  Future<List<dynamic>> getAllKeys(String boxName) async {
    final box = await _getBox(boxName);
    return box.keys.toList();
  }

  @override
  Future<void> closeBox(String boxName) async {
    await HiveBoxManager.closeBox(boxName);
  }

  @override
  Future<void> saveAll<T>(String boxName, Map<dynamic, T> values) async {
    final box = await _getBox<T>(boxName);
    await box.putAll(values);
  }

  @override
  Future<Map<dynamic, T>> getAll<T>(String boxName) async {
    final box = await _getBox<T>(boxName);
    return box.toMap();
  }
}
