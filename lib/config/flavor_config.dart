//lib/config/flavor_config.dart
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


  static late FlavorConfig _instance;

  factory FlavorConfig({
    required Flavor flavor,
    required FlavorValues values,
  }) {
    _instance = FlavorConfig._internal(
      flavor,
      enumName(flavor.toString()),
      values,
    );
    return _instance;
  }

  FlavorConfig._internal(
    this.flavor,
    this.name,
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
