import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/data/local/storage_helper.dart';

//lib/features/splash/presentation/controller/splash_controller.dart
class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation, fadeAnimation;

  @override
  void onInit() async {
    try {
      initAnimations();
    } catch (e) {
      Get.log('Splash animation error: $e');
      navigateToNextScreen();
    }
    super.onInit();
  }

  void initAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(
              const Duration(milliseconds: 500), navigateToNextScreen);
        }
      });

    scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeInOut),
      ),
    );

    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    animationController.forward();
  }

  Future<void> navigateToNextScreen() async {
    try {
      final isLoggedIn = await StorageHelper().getIsLoggedIn();

      Get.offNamed(isLoggedIn ? AppRoutes.logInScreen : AppRoutes.logInScreen);
    } catch (e) {
      Get.log('Navigation error: $e');
      Get.offNamed(AppRoutes.logInScreen);
    }
  }

  @override
  void onClose() {
    animationController
      ..removeStatusListener((status) {})
      ..dispose();
    super.onClose();
  }
}
