import 'package:flutter/material.dart';

Widget appDropDown(
    {FocusNode? focusNode,
    String? value,
    String? labelText,
    IconData? icon,
    required List<String> items,
    Function(String?)? onChanged,
    String? Function(String?)? validator}) {
  return Focus(
    focusNode: focusNode,
    child: Builder(
      builder: (context) {
        return DropdownButtonFormField<String>(
          value: value,
          items: items.map((city) {
            return DropdownMenuItem(
              value: city,
              child: Text(city),
            );
          }).toList(),
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            labelText: labelText,
            prefixIcon: Icon(icon ?? Icons.list_alt_outlined),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      },
    ),
  );
}
