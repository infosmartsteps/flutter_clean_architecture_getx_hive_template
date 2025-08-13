import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/constants/hive_constants.dart';
import '../../../../core/constants/images_assets.dart';
import '../../../../core/controllers/lang_controller.dart';
import '../../../../core/data/local/data/datasources/local_storage_data_source.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/image.dart';
import '../controller/login_controller.dart';

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: SizeConfig.screenHeight -
                SizeConfig.getProportionateScreenHeight(40),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizeConfig.getProportionateScreenWidth(24),
            ),
            child: Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor:
                    Colors.blueAccent.withValues(alpha: 0.8),
                    padding:
                    EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 8,
                    shadowColor: Colors.blueAccent.withValues(alpha: 0.5),
                  ),
                  onPressed: () async {
                    // print('Current locale: ${Get.locale}');
                    // final localStorage = LocalStorageDataSourceImpl();
                    final newLocale = Get.locale?.languageCode == 'en'
                        ? const Locale('ar', 'JO')
                        : const Locale('en', 'US');
                    //
                    // // Update the locale
                    // Get.updateLocale(newLocale);
                    //
                    // // Save the selected language to Hive
                    // await localStorage.save<String>(
                    //   HiveConstants.settingsBox,
                    //   HiveConstants.appLang,
                    //   newLocale.languageCode,
                    // );
                    // print('New locale: ${Get.locale}');
                    Get.find<LanguageController>().changeLanguage(newLocale.languageCode);
                  },
                  child: Text(
                    'update_language'.tr+"  "+"lang".tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 18,
                      letterSpacing: 1.1,
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Back!',
                      style: Get.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.colorScheme.primary,
                      ),
                    ),
                    Gap(SizeConfig.getProportionateScreenHeight(8)),
                    Text(
                      'Please login to continue',
                      style: Get.textTheme.bodyLarge?.copyWith(
                        color:
                            Get.theme.colorScheme.onBackground.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),
                Gap(SizeConfig.getProportionateScreenHeight(40)),

                // Login Form with rounded corners
                Container(
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(
                      SizeConfig.getProportionateScreenWidth(20)),
                  child: Form(
                    key: controller.formKey,
                    child: Column(
                      children: [
                        // Username Field
                        AppTextFormField(
                          label: 'Username or Email',
                          hint: 'Enter your username or email',
                          controller: controller.usernameController,
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Get.theme.colorScheme.primary,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        Gap(SizeConfig.getProportionateScreenHeight(20)),

                        // Password Field
                        AppTextFormField(
                          label: 'Password',
                          hint: 'Enter your password',
                          controller: controller.passwordController,
                          isPassword: true,
                          obscureText: true,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Get.theme.colorScheme.primary,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.visibility_outlined,
                              color: Get.theme.colorScheme.onSurface
                                  .withOpacity(0.4),
                            ),
                            onPressed: () {},
                            // onPressed: controller.togglePasswordVisibility,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        // Gap(SizeConfig.getProportionateScreenHeight(8)),
                      ],
                    ),
                  ),
                ),
                Gap(SizeConfig.getProportionateScreenHeight(30)),

                // Login Button
                Obx(
                  () => AppButton(
                    text: 'Login',
                    onPressed: controller.onLogin,
                    isLoading: controller.isLoading.value,
                    backgroundColor: Get.theme.colorScheme.primary,
                    textColor: Get.theme.colorScheme.onPrimary,
                    // elevation: 2,
                    borderRadius: 12,
                  ),
                ),
                Gap(SizeConfig.getProportionateScreenHeight(20)),
                Text(
                  'KSA Real Estate',
                  style: Get.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Get.theme.colorScheme.onBackground,
                  ),
                ),
                Gap(SizeConfig.getProportionateScreenHeight(12)),
                // App Logo and Name at the bottom
                Column(
                  children: [
                    appImage(ImagesAssets.appLogo,
                        height: SizeConfig.getProportionateScreenHeight(70),
                        width: SizeConfig.getProportionateScreenWidth(300),
                        fit: BoxFit.cover),
                    Gap(SizeConfig.getProportionateScreenHeight(4)),
                    Text(
                      'Version 1.0.0',
                      style: Get.textTheme.bodySmall?.copyWith(
                        color:
                            Get.theme.colorScheme.onBackground.withOpacity(0.4),
                      ),
                    ),
                    Gap(SizeConfig.getProportionateScreenHeight(20)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
