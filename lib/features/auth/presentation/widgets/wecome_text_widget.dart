import 'package:flutter/material.dart';
import 'package:get/get.dart';

//lib/features/auth/presentation/widgets/wecome_text_widget.dart
Widget welcomeTextWidget(BuildContext context) {
  //welcome text widget
  return RichText(
    textAlign: TextAlign.center,
    text: TextSpan(
      text: '${'Welcome Back!'.tr}\n',
      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary),
      children: [
        TextSpan(
            text: 'Please login to continue'.tr,
            style: Theme.of(context).textTheme.bodyMedium),
      ],
    ),
  );
}
