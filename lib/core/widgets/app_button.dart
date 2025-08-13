import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/responsive_size_helper.dart';

enum AppButtonType { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool disabled;
  final Widget? icon;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.disabled = false,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 8.0,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final buttonWidth = width ?? double.infinity;
    final buttonHeight = height ?? SizeConfig.getProportionateScreenHeight(48);

    Color bgColor = backgroundColor ?? Get.theme.primaryColor;
    Color fgColor = textColor ?? Colors.white;
    Color borderColor = Get.theme.primaryColor;

    if (type == AppButtonType.secondary) {
      bgColor = Get.theme.colorScheme.secondary;
      fgColor = Get.theme.colorScheme.onSecondary;
    } else if (type == AppButtonType.outline) {
      bgColor = Colors.transparent;
      fgColor = Get.theme.primaryColor;
      borderColor = Get.theme.primaryColor;
    } else if (type == AppButtonType.text) {
      bgColor = Colors.transparent;
      fgColor = Get.theme.primaryColor;
      borderColor = Colors.transparent;
    }

    if (disabled) {
      bgColor = bgColor.withOpacity(0.5);
      fgColor = fgColor.withOpacity(0.5);
    }

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: type == AppButtonType.outline ? borderColor : Colors.transparent,
              width: 1.0,
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: SizeConfig.getProportionateScreenWidth(16),
              ),
        ),
        child: isLoading
            ? SizedBox(
          width: SizeConfig.getProportionateScreenHeight(24),
          height: SizeConfig.getProportionateScreenHeight(24),
          child: CircularProgressIndicator(
            color: fgColor,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: SizeConfig.getProportionateScreenWidth(8)),
            ],
            Text(
              text,
              style: Get.textTheme.labelLarge?.copyWith(
                color: fgColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}