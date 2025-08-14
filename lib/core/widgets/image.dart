import 'package:flutter/material.dart';

Image appImage(String assets,
    {double? height, double? width, BoxFit? fit = BoxFit.fill, Color? color}) {
  return Image.asset(
    assets,
    height: height,
    width: width,
    fit: fit,
    color: color,
  );
}
