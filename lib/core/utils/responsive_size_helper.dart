import 'package:flutter/material.dart';
import 'package:get/get.dart';

//lib/core/utils/responsive_size_helper.dart
Size displaySize() {
  return MediaQuery.sizeOf(Get.context!);
}

double displayHeight() {
  return displaySize().height;
}

double displayWidth() {
  return displaySize().width;
}

double responsiveHeight(double value, {double baseHeight = 900}) {
  return (value / baseHeight) * displayHeight();
}

double responsiveWidth(double value, {double baseWidth = 400}) {
  return (value / baseWidth) * displayWidth();
}

double responsiveFont(double value) {
  return value * (displayWidth() / 3) / 100;
}
