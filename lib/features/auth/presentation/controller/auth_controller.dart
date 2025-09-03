import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../domain/params/log_in_params.dart';
import '../../domain/usecases/login_usecase.dart';

//lib/features/auth/presentation/controller/auth_controller.dart
class AuthController extends GetxController {
  final LoginUseCase loginUseCase;

  AuthController({required this.loginUseCase});

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
  void onInit()  {
    super.onInit();
     getAppInfo();
  }

  Future<void> onLogin() async {
    if (!formKey.currentState!.validate()) return;
    isLoading.value = true;
    try {
      final params = LogInParameters(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
      );
      final result = await loginUseCase.login(params);
      result.fold(
        (l) => Get.snackbar('Login Failed', l,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Get.theme.colorScheme.error,
            colorText: AppColors.whiteColor),
        (r) => Get.offNamed(AppRoutes.homeScreen));
    } finally {
      isLoading.value = false;
    }
  }

  toggleIsObscureText() {
    isObscureText.value = !isObscureText.value;
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> getAppInfo() async {
    final PackageInfo packageInfo = await StorageHelper().getAppInfo();
    final locale = await StorageHelper().getAppLang();
    this.packageInfo.value = packageInfo;
    isEnglish.value = locale == LanguageLocals.english;
  }
}
