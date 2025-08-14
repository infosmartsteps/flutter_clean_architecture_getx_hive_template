import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/app_constants.dart';
import '../../constants/hive_constants.dart';
import 'i_storage.dart';

class StorageHelper {
  final IStorage _storage = Get.find();

//======================== settingsBox =========================================
  //================ lang ============
  Future<Locale> getAppLang() async {
    final Locale locale = await _storage.get(HiveConstants.appLang,
            boxName: HiveConstants.settingsBox) ??
        LanguageLocals.english;
    return locale;
  }

  Future<void> setAppLang(Locale locale) async {
    await _storage.save(HiveConstants.appLang, locale,
        boxName: HiveConstants.settingsBox);
  }

//=================== theme ============
  Future<ThemeMode?> getAppThemeMode() async {
    final ThemeMode? themeMode = await _storage.get(HiveConstants.themeModeKey,
        boxName: HiveConstants.settingsBox);
    return themeMode;
  }

  Future<void> setAppThemeMode(ThemeMode themeMode) async {
    await _storage.save(HiveConstants.themeModeKey, themeMode,
        boxName: HiveConstants.settingsBox);
  }

  //============================ userBox =======================================
  Future<void> setUser(UserModel user) async {
    await _storage.save(HiveConstants.userProfileKey, user,
        boxName: HiveConstants.userDataBox);
  }

  Future<String?> getAuthTokenKey() async {
    final UserModel? user = await _storage.get(HiveConstants.userProfileKey,
        boxName: HiveConstants.userDataBox);
    final String? token = user?.token;
    return token;
  }

  Future<bool> getIsLoggedIn() async {
    final String? token = await getAuthTokenKey();
    return token != null && token.isNotEmpty;
  }
}

class UserModel {
  final String? token;
  final String? name;
  final String? id;

  UserModel({this.token, this.name, this.id});
}
