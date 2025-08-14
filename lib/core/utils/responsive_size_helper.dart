import 'package:flutter/material.dart';
import 'package:get/get.dart';

Size displaySize() {
  return MediaQuery.sizeOf(Get.context!);
}

double displayHeight() {
  return displaySize().height;
}

double displayWidth() {
  return displaySize().width;
}

double responsiveHeight(double value, {double baseHeight = 915}) {
  double screenHeight = MediaQuery.sizeOf(Get.context!).height;
  return (value / baseHeight) * screenHeight;
}

double responsiveWidth(double value, {double baseWidth = 412}) {
  double screenWidth = MediaQuery.sizeOf(Get.context!).width;
  return (value / baseWidth) * screenWidth;
}

double responsiveFont(double value) {
  double screenWidth = MediaQuery.sizeOf(Get.context!).width;
  return value * (screenWidth / 3) / 100;
}
