import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';
import 'package:ksa_real_estates/core/constants/enums.dart';
import '../../features/auth/presentation/controller/auth_controller.dart';
import '../utils/form_utils.dart';
import '../utils/responsive_size_helper.dart';
import 'app_button.dart';

//lib/core/widgets/app_text_form_field.dart
class AppTextFormField extends StatelessWidget {
  final FormFieldModel? fieldModel;
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
  final FocusNode? focusNode;
  final TextStyle? textStyle;
  final double? height;
  final double? width;

  const AppTextFormField({
    super.key,
    required this.label,
    this.fieldModel,
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
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.minLines,
    this.readOnly = false,
    this.showLabel = false,
    this.contentPadding,
    this.fillColor,
    this.borderColor,
    this.borderRadius = 8.0,
    this.borderWidth = 1.0,
    this.enabled = true,
    this.onTap,
    this.focusNode,
    this.textStyle,
    this.height,
    this.width,
  }) : assert(fieldModel != null || controller != null,
            'Either fieldModel or controller must be provided');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: fieldModel?.key,
      width: width,
      height: height,
      child: TextFormField(
        focusNode: fieldModel?.focusNode ?? focusNode,
        controller: fieldModel?.controller ?? controller,
        validator: fieldModel?.validator ?? validator,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        keyboardType: keyboardType,
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
        style: textStyle,
        decoration: _buildDecoration(context),
      ),
    );
  }

  InputDecoration _buildDecoration(BuildContext context) {
    return InputDecoration(
      labelText: showLabel ? label : null,
      hintText: hint ?? (!showLabel ? label:null),
      hintStyle: Theme.of(context).textTheme.bodySmall,
      prefixIcon: prefixIcon,
      suffixIcon: _buildSuffixIcon(),
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: responsiveWidth(16),
            vertical: responsiveHeight(14),
          ),
      filled: true,
      fillColor: fillColor ?? Get.theme.colorScheme.surface,
      border: _buildBorder(),
      enabledBorder: _buildBorder(),
      focusedBorder: _buildBorder(isFocused: true),
      errorBorder: _buildBorder(isError: true),
      focusedErrorBorder: _buildBorder(isError: true, isFocused: true),
    );
  }

  Widget? _buildSuffixIcon() {
    if (isPassword) {
      return AppButton(
        type: AppButtonType.secondary,
        backgroundColor: AppColors.transparent,
        icon: Icon(
          obscureText ? Icons.visibility_off : Icons.visibility,
          color: Get.theme.colorScheme.onSurface.withOpacity(0.6),
        ),
        onPressed: _togglePasswordVisibility,
      );
    }
    return suffixIcon;
  }

  void _togglePasswordVisibility() {
    Get.find<AuthController>().toggleIsObscureText();
    final currentController = fieldModel?.controller ?? controller;
    if (currentController != null) {
      final currentValue = currentController.text;
      currentController.text = '';
      currentController.text = currentValue;
    }
  }

  OutlineInputBorder _buildBorder(
      {bool isFocused = false, bool isError = false}) {
    Color borderColor;

    if (isError) {
      borderColor = Get.theme.colorScheme.error;
    } else if (isFocused) {
      borderColor = this.borderColor ?? Get.theme.colorScheme.primary;
    } else {
      borderColor = this.borderColor ?? Get.theme.colorScheme.outline;
    }

    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(color: borderColor, width: borderWidth),
    );
  }
}
