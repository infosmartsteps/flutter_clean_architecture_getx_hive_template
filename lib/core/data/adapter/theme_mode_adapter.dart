import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class ThemeModeAdapter extends TypeAdapter<ThemeMode> {
  @override
  final int typeId = 0; // Unique identifier for this adapter

  @override
  ThemeMode read(BinaryReader reader) {
    final index = reader.readByte();
    switch (index) {
      case 0:
        return ThemeMode.system;
      case 1:
        return ThemeMode.light;
      case 2:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  @override
  void write(BinaryWriter writer, ThemeMode obj) {
    switch (obj) {
      case ThemeMode.system:
        writer.writeByte(0);
        break;
      case ThemeMode.light:
        writer.writeByte(1);
        break;
      case ThemeMode.dark:
        writer.writeByte(2);
        break;
    }
  }
}