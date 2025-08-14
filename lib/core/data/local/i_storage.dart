// core/data/local/storage.dart
abstract class IStorage {
  Future<void> init();
  Future<void> save(String key, dynamic value,{required String boxName});
  dynamic get(String key,{required String boxName});
  Future<void> delete(String key,{required String boxName});
  Future<void> put(String key, dynamic value,{required String boxName});
  Future<void> clear();
}