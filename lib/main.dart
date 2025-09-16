import 'dart:async';
import 'package:flutter/material.dart';
import 'app.dart';
import 'core/di/app_initializer.dart';
import 'core/di/dependency_injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initializeApp();
}

Future<void> _initializeApp() async {
  await AppInitializer.init();
  await DependencyInjection.init();
  runApp(App());
}
