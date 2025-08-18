import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../domain/params/log_in_params.dart';
import '../../domain/use_cases/login_use_case.dart';

//lib/features/auth/presentation/controller/auth_controller.dart
class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController({required this.loginUseCase});

  // Form Key
  final formKey = GlobalKey<FormState>();

  Rx<PackageInfo> packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '')
          .obs;

  RxBool isObscureText = true.obs;

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
    await getAppInfo();
  }

  // Handlers
  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;

    isLoading.value = true;
    update();
    try {
      final params = LogInParameters(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      final result = await loginUseCase.login(params);

      result.fold(
        (failure) {
          Get.snackbar(
            'Login Failed',
            failure,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.colorScheme.error,
            colorText: Colors.white,
          );
        },
        (success) {
          // Navigate to home on success
          Get.offNamed(AppRoutes.homeScreen);
        },
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  toggleIsObscureText() {
    isObscureText.value = !isObscureText.value;
    // update();
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> getAppInfo() async {
    final PackageInfo packageInfo = await StorageHelper().getAppInfo();
    this.packageInfo.value = packageInfo;
  }
}
