import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';
import 'package:ksa_real_estates/core/data/local/storage_helper.dart';
import 'app.dart';
import 'config/base_url_config.dart';
import 'config/flavor_config.dart';
import 'config/theme/app_theme.dart';
import 'core/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
}

Future<void> _initializeApp() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await DependencyInjection.init();
  runApp(App());
}
