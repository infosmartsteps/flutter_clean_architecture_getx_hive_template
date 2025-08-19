import 'package:flutter/material.dart';

import '../constants/images_assets.dart';
import '../utils/responsive_size_helper.dart';
import 'image.dart';

Widget appLogo({double? height, double? width}) {
  return appImage(ImagesAssets.appLogo,
      height: height ?? responsiveHeight(90),
      width: width ?? responsiveWidth(400),
      fit: BoxFit.cover);
}
