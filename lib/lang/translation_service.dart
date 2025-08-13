import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../core/constants/hive_constants.dart';
import '../core/data/local/data/datasources/local_storage_data_source.dart';
import 'en_US.dart';
import 'ar_JO.dart';

class TranslationService extends Translations {


  static const fallbackLocale = Locale('en', 'US');

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': en_US,
    'ar_JO': ar_JO,
  };
}