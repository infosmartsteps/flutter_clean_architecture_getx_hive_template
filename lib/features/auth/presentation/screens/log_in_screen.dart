import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_logo.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../../../../core/widgets/lang_toggle_Button.dart';
import '../../../../core/widgets/theme_toggle_button.dart';
import '../controller/auth_controller.dart';

class LogInScreen extends GetView<AuthController> {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(24),
              ),
              child: Row(
                children: [
                  themeToggleButton(),
                  Gap(responsiveWidth(10)),
                  languageToggleButton(),
                ],
              ),
            )
          ],
        ),
        body: SafeArea(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: displayHeight() - responsiveHeight(40),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: responsiveWidth(24),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Welcome Back!'.tr,
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        Gap(responsiveHeight(8)),
                        Text('Please login to continue'.tr,
                            style: Theme.of(context).textTheme.bodyLarge),
                      ],
                    ),
                    Gap(responsiveHeight(40)),
                    // Login Form with rounded corners
                    Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.surface,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey[700]!,
                            blurRadius: 16,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(responsiveWidth(20)),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            // Username Field
                            AppTextFormField(
                              label: 'Username or Email'.tr,
                              hint: 'Enter your username or email'.tr,
                              controller: controller.usernameController,
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your username'.tr;
                                }
                                return null;
                              },
                            ),
                            Gap(responsiveHeight(20)),
                            // Password Field
                            Obx(
                              () => AppTextFormField(
                                label: 'Password'.tr,
                                hint: 'Enter your password'.tr,
                                controller: controller.passwordController,
                                isPassword: true,
                                obscureText: controller.isObscureText.value,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.visibility_outlined,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.4),
                                  ),
                                  onPressed: () {},
                                  // onPressed: controller.togglePasswordVisibility,
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter your password'.tr;
                                  }
                                  if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Gap(responsiveHeight(30)),
                    // Login Button
                    Obx(
                      () => AppButton(
                        type: AppButtonType.primary,
                        text: 'login'.tr,
                        onPressed: controller.onLogin,
                        isLoading: controller.isLoading.value,
                        borderRadius: 12,
                      ),
                    ),
                    Gap(responsiveHeight(20)),
                    Obx(
                      () => Text(controller.appName.toString(),
                          style: Theme.of(context).textTheme.titleMedium),
                    ),
                    // App Logo and Name at the bottom
                    appLogo(),
                    Gap(responsiveHeight(10)),
                    Obx(() => Text(controller.version.toString(),
                        style: Theme.of(context).textTheme.bodyMedium)),
                    Gap(responsiveHeight(20)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
