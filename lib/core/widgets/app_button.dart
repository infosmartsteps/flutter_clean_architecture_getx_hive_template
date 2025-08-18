import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../utils/responsive_size_helper.dart';

enum AppButtonType { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final AppButtonType type;
  final bool isLoading;
  final bool disabled;
  final bool isMin;
  final Widget? icon;
  final double? width; // Optional width if you still want to force it
  final double? height; // Optional height if you still want to force it
  final Color? backgroundColor;
  final Color? textColor;
  final double borderRadius;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    this.text,
    required this.onPressed,
    this.type = AppButtonType.primary,
    this.isLoading = false,
    this.disabled = false,
    this.icon,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.borderRadius = 12,
    this.padding,
    this.isMin = false,
  });

  @override
  Widget build(BuildContext context) {
    // Only use width/height if explicitly provided, otherwise null (which will make it fit content)
    var buttonWidth = width;
    var buttonHeight = height;

    Color bgColor = backgroundColor ?? Get.theme.colorScheme.primary;
    Color fgColor = textColor ?? Get.theme.colorScheme.onPrimary;
    Color borderColor = Get.theme.primaryColor;
    if (type == AppButtonType.primary) {
      buttonWidth = width ?? double.infinity;
      buttonHeight = height ?? responsiveWidth(48);
    } else if (type == AppButtonType.secondary) {
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
      // Will be null if not provided, making it fit content
      height: buttonHeight,
      // Will be null if not provided, making it fit content
      child: ElevatedButton(
        onPressed: disabled || isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            side: BorderSide(
              color: type == AppButtonType.outline
                  ? borderColor
                  : Colors.transparent,
              width: 1.0,
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: padding ??
              EdgeInsets.symmetric(
                horizontal: responsiveWidth(12), // Reduced padding
                vertical: responsiveHeight(8), // Reduced padding
              ),
          minimumSize: Size.zero,
          // This is key to removing minimum size constraints
          tapTargetSize: MaterialTapTargetSize
              .shrinkWrap, // Makes the tap target fit the content
        ),
        child: isLoading
            ? SizedBox(
                width: responsiveWidth(24),
                height: responsiveHeight(24),
                child: CircularProgressIndicator(
                  color: fgColor,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                // This makes the row take minimum space
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) icon!,
                  if (icon != null && text != null) Gap(responsiveWidth(8)),
                  if (text != null)
                    Text(
                      text!,
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
