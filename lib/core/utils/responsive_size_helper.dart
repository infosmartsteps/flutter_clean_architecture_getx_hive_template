import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late Orientation orientation;

  static void init() {
    _mediaQueryData = MediaQuery.of(Get.context!);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    // Divide screen into 100 blocks horizontally and vertically
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;

    // Calculate safe area blocks (considering notches, status bars, etc.)
    _safeAreaHorizontal = _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical = _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;
    safeBlockHorizontal = (screenWidth - _safeAreaHorizontal) / 100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
  }

  // Get the proportionate height as per screen size
  static double getProportionateScreenHeight(double inputHeight) {
    double screenHeight = SizeConfig.screenHeight;
    // 812 is the layout height that designer use (iPhone 13)
    return (inputHeight / 812.0) * screenHeight;
  }

  // Get the proportionate width as per screen size
  static double getProportionateScreenWidth(double inputWidth) {
    double screenWidth = SizeConfig.screenWidth;
    // 375 is the layout width that designer use (iPhone 13)
    return (inputWidth / 375.0) * screenWidth;
  }

  // Get the font size scaled according to screen size
  static double getScaledFontSize(double fontSize, {double scaleFactor = 0.5}) {
    // scaleFactor determines how much the font scales with screen size
    // 0.5 means font scales halfway between smallest and largest screens
    return fontSize + (scaleFactor * (SizeConfig.blockSizeHorizontal - 4));
  }

  // Check if screen is in landscape mode
  static bool isLandscape() {
    return orientation == Orientation.landscape;
  }

  // Check if screen is mobile sized (less than 600px width)
  static bool isMobile() {
    return screenWidth < 600;
  }

  // Check if screen is tablet sized (600px width or more)
  static bool isTablet() {
    return screenWidth >= 600;
  }

  // Check if screen is desktop sized (1200px width or more)
  static bool isDesktop() {
    return screenWidth >= 1200;
  }
}