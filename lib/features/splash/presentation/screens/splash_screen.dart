import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/images_assets.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/image.dart';
import '../../../../core/widgets/app_logo.dart';
import '../controller/splash_controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: AnimatedBuilder(
              animation: controller.animationController,
              builder: (context, child) {
                return Opacity(
                  opacity: controller.fadeAnimation.value,
                  child: Transform.scale(
                    scale: controller.scaleAnimation.value,
                    child: child,
                  ),
                );
              },
              child: appLogo()),
        ),
      ),
    );
  }
}
