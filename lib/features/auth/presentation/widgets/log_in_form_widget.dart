import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../controller/auth_controller.dart';

//lib/features/auth/presentation/widgets/log_in_form_widget.dart
Widget logInFormWidget(BuildContext context, AuthController controller) {
  // Login Form with rounded corners
  return Container(
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
  );
}
