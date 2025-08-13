
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../constants/hive_constants.dart';

// lib/core/data/local/data/datasources/hive_box_manager.dart
class HiveBoxManager {

  static String? getLanguage() {
    return Hive.box(HiveConstants.settingsBox).get(HiveConstants.appLang);
  }

  static Future<void> saveLanguage(String langCode) async {
    await Hive.box(HiveConstants.settingsBox).put(HiveConstants.appLang, langCode);
  }
  static Future<void> init() async {
    try {
      await Hive.initFlutter();

      await Hive.openBox(HiveConstants.settingsBox);
    } catch (e) {
      throw Exception('Failed to initialize Hive: $e');
    }
  }

  static Future<Box<T>> openBox<T>(String boxName) async {
    try {
      if (!Hive.isBoxOpen(boxName)) {
        return await Hive.openBox<T>(boxName);
      }
      return Hive.box<T>(boxName);
    } catch (e) {
      throw Exception('Failed to open box $boxName: $e');
    }
  }

  static Future<void> closeBox(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).close();
      }
    } catch (e) {
      throw Exception('Failed to open box $boxName: $e');
    }
  }

  static Future<void> deleteBox(String boxName) async {
    try {
      if (Hive.isBoxOpen(boxName)) {
        await Hive.box(boxName).deleteFromDisk();
      } else {
        await Hive.deleteBoxFromDisk(boxName);
      }
    } catch (e) {
      throw Exception('Failed to open box $boxName: $e');
    }
  }

  static Future<void> clearAllData() async {
    try {
      await deleteBox(HiveConstants.settingsBox);
      await deleteBox(HiveConstants.userDataBox);
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<void> closeAllBoxes() async {
    try {
      await Hive.close();
    } catch (e) {
      throw Exception(e);
    }
  }
}
