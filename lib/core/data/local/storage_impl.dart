import 'package:hive/hive.dart';
import '../../constants/hive_constants.dart';
import 'i_storage.dart';

class StorageImpl implements IStorage {
  late Box _settingsBox;
  late Box _userDataBox;

  @override
  Future<void> init() async {
    _settingsBox = await Hive.openBox(HiveConstants.settingsBox);
    _userDataBox = await Hive.openBox(HiveConstants.userDataBox);
  }

  @override
  Future<void> save(String key, dynamic value,
      {required String boxName}) async {
    if (boxName == HiveConstants.settingsBox) {
      await _settingsBox.put(key, value);
    } else {
      await _userDataBox.put(key, value);
    }
  }

  @override
  dynamic get(String key, {required String boxName}) {
    if (boxName == HiveConstants.settingsBox) {
      return _settingsBox.get(key);
    } else {
      return _userDataBox.get(key);
    }
  }

  @override
  Future<void> delete(String key, {required String boxName}) async {
    if (boxName == HiveConstants.settingsBox) {
      await _settingsBox.delete(key);
    } else {
      await _userDataBox.delete(key);
    }
  }

  @override
  Future<void> put(String key, dynamic value, {required String boxName}) async {
    if (boxName == HiveConstants.settingsBox) {
      await _settingsBox.put(key, value);
    } else {
      await _userDataBox.put(key, value);
    }
  }

  @override
  Future<void> clear() async {
    await _settingsBox.clear();
    await _userDataBox.clear();
  }
}
