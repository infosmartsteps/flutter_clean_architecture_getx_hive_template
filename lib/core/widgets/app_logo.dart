import 'package:flutter/material.dart';

import '../constants/images_assets.dart';
import '../utils/responsive_size_helper.dart';
import 'image.dart';

Widget appLogo() {
  return appImage(
      ImagesAssets.appLogo,
      height: responsiveHeight(90),
      width: responsiveWidth(350),
      fit: BoxFit.cover);
}
