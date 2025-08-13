import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';
import 'app.dart';
import 'config/base_url_config.dart';
import 'config/flavor_config.dart';
import 'core/di/app_bindings.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    await Get.putAsync(() async {
      final bindings = AppBindings();
      await bindings.dependencies();
      return bindings;
    });
    final flavorConfig = FlavorConfig(
      flavor: Flavor.development,
      values: FlavorValues(baseUrlEndpoint: BaseUrlConfig().baseUrlDevelopment),
      colorPrimary: AppColors.whiteColor,
    );

    runApp(App(flavorConfig: flavorConfig));
  } catch (error, stackTrace) {
    debugPrint('Initialization failed: $error');
    debugPrint(stackTrace.toString());
    runApp(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Failed to initialize app'),
          ),
        ),
      ),
    );
  }
}
