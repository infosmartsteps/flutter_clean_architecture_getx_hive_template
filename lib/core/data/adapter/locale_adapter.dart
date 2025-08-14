import 'package:hive/hive.dart';
import 'package:flutter/material.dart';

class LocaleAdapter extends TypeAdapter<Locale> {
  @override
  final int typeId = 1; // Choose a unique ID for your adapter

  @override
  Locale read(BinaryReader reader) {
    final languageCode = reader.readString();
    final countryCode = reader.readString();
    return Locale(languageCode, countryCode);
  }

  @override
  void write(BinaryWriter writer, Locale obj) {
    writer.writeString(obj.languageCode);
    writer.writeString(obj.countryCode ?? '');
  }
}