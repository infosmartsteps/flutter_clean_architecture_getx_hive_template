import 'package:flutter/material.dart';

enum Flavor {
  development,
  production,
}

class FlavorValues {
  final String baseUrlEndpoint;

  FlavorValues({required this.baseUrlEndpoint});
}

class FlavorConfig {
  final Flavor flavor;
  final String name;
  final FlavorValues values;
  final Color colorPrimary;
  final Color colorPrimaryDark;
  final Color colorPrimaryLight;
  final Color colorAccent;

  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
    Color? colorPrimary,
    Color colorPrimaryDark = Colors.blue,
    Color colorPrimaryLight = Colors.blue,
    Color colorAccent = Colors.blueAccent,
  }) {
    _instance = FlavorConfig._internal(
      flavor,
      enumName(flavor.toString()),
      colorPrimary ?? Colors.blue,
      colorPrimaryDark,
      colorPrimaryLight,
      colorAccent,
      values,
    );
    return _instance;
  }

  FlavorConfig._internal(
    this.flavor,
    this.name,
    this.colorPrimary,
    this.colorPrimaryDark,
    this.colorPrimaryLight,
    this.colorAccent,
    this.values,
  );

  static FlavorConfig get instance => _instance;

  static String enumName(String enumToString) {
    final paths = enumToString.split('.');
    return paths[paths.length - 1];
  }

  static bool isProduction() => _instance.flavor == Flavor.production;

  static bool isDevelopment() => _instance.flavor == Flavor.development;
}
