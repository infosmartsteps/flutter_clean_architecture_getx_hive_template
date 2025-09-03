import 'package:get/get.dart';

import 'app_constants.dart';

class FontFamily {
  static const encodeSans = 'EncodeSans';
  static const cairo = 'Cairo';

  static String getFontFamily() {
    return Get.locale?.languageCode == LanguageLocals.arabic.languageCode
        ? cairo
        : encodeSans;
  }
}
