import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/app.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../../../core/localization/translations/translation_service.dart';
import '../../domain/use_cases/login_use_case.dart';

//lib/features/auth/presentation/controller/auth_controller.dart
class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController({required this.loginUseCase});

  // Form Key
  final formKey = GlobalKey<FormState>();

  RxString appName = "".obs;
  RxString version = "".obs;

  // Controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // States
  var isLoading = false.obs;
  var isEnglish = true.obs;

  @override
  void onInit() async {
    super.onInit();
    final locale = await StorageHelper().getAppLang();
    isEnglish.value = locale == LanguageLocals.english;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName.value = packageInfo.appName;
    version.value = packageInfo.version;
  }

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

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
