import 'package:flutter/material.dart';

class FontSize {
  static const size24 = 18.0;
  static const size20 = 14.0;
  static const size16 = 10.0;
  static const size15 = 9.0;
  static const size32 = 24.1;
  static const size36 = 27.0;
  static const size14 = 8.0;
  static const size13 = 7.0;
}

class LanguageCodes {
  static const arabic = 'ar';
  static const english = 'en';
}

class Languages {
  static const arabic = 'العربية';
  static const english = 'English';
}

class LanguagesCountries {
  static const us = 'US';
  static const jo = "JO";
}

class LanguageLocals {
  static const arabic = Locale(LanguageCodes.arabic, LanguagesCountries.jo);
  static const english = Locale(LanguageCodes.english, LanguagesCountries.us);
}
