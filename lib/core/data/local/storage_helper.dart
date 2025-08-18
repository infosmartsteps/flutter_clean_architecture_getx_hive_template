import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../features/auth/data/models/log_in_model.dart';
import '../../../features/auth/domain/entities/login_entity.dart';
import '../../constants/app_constants.dart';
import '../../constants/hive_constants.dart';
import 'i_storage.dart';

class StorageHelper {
  final IStorage _storage = Get.find();

//======================== settingsBox =========================================
  //================ lang ============
  Future<Locale> getAppLang() async {
    final Locale locale = await _storage.get(HiveConstants.appLang, boxName: HiveConstants.settingsBox)??
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
  Future<void> setUser(LogInModel user) async {
    await _storage.save(HiveConstants.userProfileKey, user,
        boxName: HiveConstants.userDataBox);
  }

  Future<LogInEntity> getUser() async {
    final LogInModel user = await _storage.get(HiveConstants.userProfileKey,
        boxName: HiveConstants.userDataBox);
    final LogInEntity userEntity = LogInEntity.fromResponse(user);
    return userEntity;
  }

  Future<String?> getAuthTokenKey() async {
    final LogInModel? user = await _storage.get(HiveConstants.userProfileKey,
        boxName: HiveConstants.userDataBox);
    final String? token = user?.accessToken;
    return token;
  }

  Future<bool> getIsLoggedIn() async {
    final String? token = await getAuthTokenKey();
    return token != null && token.isNotEmpty;
  }

  Future<void> setAppInfo(PackageInfo packageInfo) async {
    await _storage.save(HiveConstants.appInfo, packageInfo,
        boxName: HiveConstants.settingsBox);
  }

  Future<PackageInfo> getAppInfo() async {
    final PackageInfo packageInfo = await _storage.get(HiveConstants.appInfo,
        boxName: HiveConstants.settingsBox);
    return packageInfo;
  }

  Future<void> logout() async{
    await _storage.delete(HiveConstants.userProfileKey, boxName: HiveConstants.userDataBox);
  }
}
