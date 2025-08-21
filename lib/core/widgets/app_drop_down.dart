import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';

//lib/core/widgets/app_drop_down.dart
class AppDropDown extends StatelessWidget {
  final FocusNode? focusNode;
  final String? value;
  final String? labelText;
  final IconData? icon;
  final bool isLoading;
  final GlobalKey? fieldKey;
  final List<String> items;
  final Function(String?)? onChanged;
  final String? Function(String?)? validator;

  const AppDropDown({
    super.key,
    this.focusNode,
    this.value,
    this.labelText,
    this.icon,
    this.isLoading = false,
    this.fieldKey,
    required this.items,
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return _buildLoadingDropdown();
    }

    return Focus(
      focusNode: focusNode,
      child: DropdownButtonFormField<String>(
        key: fieldKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        value: value,
        items: items.map((item) => DropdownMenuItem(
          value: item,
          child: Text(item),
        )).toList(),
        onChanged: onChanged,
        validator: validator,
        decoration: _buildDecoration(),
      ),
    );
  }

  InputDecoration _buildDecoration() {
    return InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon ?? Icons.list_alt_outlined),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(responsiveFont(8)),
      ),
    );
  }

  Widget _buildLoadingDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: responsiveWidth(18),
        vertical: responsiveHeight(15),
      ),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(responsiveFont(8)),
      ),
      child: Row(
        children: [
          Icon(icon ?? Icons.list_alt_outlined),
          Gap(responsiveWidth(12)),
          Text(labelText ?? ''),
          const Spacer(),
          SizedBox(
            width: responsiveFont(20),
            height: responsiveFont(20),
            child: CircularProgressIndicator(strokeWidth: responsiveFont(2)),
          ),
        ],
      ),
    );
  }
}
