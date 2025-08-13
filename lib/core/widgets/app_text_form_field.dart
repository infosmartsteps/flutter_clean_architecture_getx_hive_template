import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../utils/responsive_size_helper.dart';


class AppTextFormField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;
  final bool isPassword;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool autoFocus;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final int? maxLines;
  final int? minLines;
  final bool readOnly;
  final bool showLabel;
  final EdgeInsetsGeometry? contentPadding;
  final Color? fillColor;
  final Color? borderColor;
  final double borderRadius;
  final double borderWidth;
  final bool enabled;
  final Function()? onTap;

  const AppTextFormField({
    Key? key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
    this.isPassword = false,
    this.keyboardType,
    this.validator,
    this.inputFormatters,
    this.prefixIcon,
    this.suffixIcon,
    this.autoFocus = false,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.showLabel = true,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.enabled = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showLabel) ...[
          Text(
            label,
            style: Get.textTheme.labelMedium?.copyWith(
              color: Get.theme.colorScheme.onSurface.withOpacity(0.8),
            ),
          ),
          SizedBox(height: SizeConfig.getProportionateScreenHeight(8)),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          autofocus: autoFocus,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          maxLines: maxLines,
          minLines: minLines,
          readOnly: readOnly,
          enabled: enabled,
          onTap: onTap,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: prefixIcon,
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Get.theme.colorScheme.onSurface.withOpacity(0.6),
              ),
              onPressed: () {
                // Toggle password visibility
                if (controller != null) {
                  final currentValue = controller!.text;
                  controller!.text = '';
                  controller!.text = currentValue;
                }
              },
            )
                : suffixIcon,
            contentPadding: contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: SizeConfig.getProportionateScreenWidth(16),
                  vertical: SizeConfig.getProportionateScreenHeight(14),
                ),
            filled: true,
            fillColor: fillColor ?? Get.theme.colorScheme.surface,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor ?? Get.theme.colorScheme.outline,
                width: borderWidth,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor ?? Get.theme.colorScheme.outline,
                width: borderWidth,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: borderColor ?? Get.theme.primaryColor,
                width: borderWidth,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: borderWidth,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius),
              borderSide: BorderSide(
                color: Get.theme.colorScheme.error,
                width: borderWidth,
              ),
            ),
          ),
        ),
      ],
    );
  }
}