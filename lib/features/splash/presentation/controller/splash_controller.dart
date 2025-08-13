import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/constants/hive_constants.dart';
import '../../../../core/data/local/data/datasources/hive_box_manager.dart';
import '../../../../core/data/local/domain/repositories/local_storage_repository.dart';
//lib/features/splash/presentation/controller/splash_controller.dart
class SplashController extends GetxController with GetSingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> scaleAnimation, fadeAnimation;
  final LocalStorageRepository localStorageRepository = Get.find();

  @override
  void onInit() {
    super.onInit();
    try {
      initAnimations();
    } catch (e) {
      Get.log('Splash animation error: $e');
      navigateToNextScreen();
    }
  }

  void initAnimations() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 500), navigateToNextScreen);
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
      // Check if user has an auth token (logged in)
      final authToken = await localStorageRepository.get<String>(HiveConstants.userDataBox, HiveConstants.authTokenKey);
      final isLoggedIn = authToken != null && authToken.isNotEmpty;

      Get.log("User is logged in: $isLoggedIn");

      // Navigate based on authentication status
      Get.offNamed(isLoggedIn ? AppRoutes.logInScreen : AppRoutes.logInScreen);
    } catch (e) {
      Get.log('Navigation error: $e');
      // Fallback to login screen if there's an error
      Get.offNamed(AppRoutes.logInScreen);
    }
  }

  @override
  void onClose() {
    animationController..removeStatusListener((status) {})..dispose();
    super.onClose();
  }
}

