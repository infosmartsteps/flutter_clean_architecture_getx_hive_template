import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/data/local/data/datasources/hive_box_manager.dart';
import '../../../../core/data/local/domain/repositories/local_storage_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../domain/use_cases/login_use_case.dart';



class LoginController extends GetxController {
  final LoginUseCase loginUseCase;

  LoginController({required this.loginUseCase});

  // Form Key
  final formKey = GlobalKey<FormState>();

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // States
  final isLoading = false.obs;

  // Handlers
  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    try {
      final result = await loginUseCase.execute(
        usernameController.text.trim(),
        passwordController.text.trim(),
      );

      result.fold(
            (failure) {
          Get.snackbar(
            'Login Failed',
            failure.message,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.colorScheme.error,
            colorText: Colors.white,
          );
        },
            (success) {
          // Navigate to home on success
          Get.offNamed('/home');
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  void onForgotPassword() {
    Get.toNamed('/forgot-password');
  }

  void onSignUp() {
    Get.toNamed('/signup');
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}