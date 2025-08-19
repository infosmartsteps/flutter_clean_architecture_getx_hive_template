import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/app_logo.dart';

//lib/features/auth/presentation/widgets/app_info_widget.dart
Widget appInfoWidget(BuildContext context, PackageInfo packageInfo) {
  // App Name and Logo and version at the bottom
  return Column(
    spacing: responsiveHeight(10),
    children: [
      // app name
      Text(packageInfo.appName.toString(),
          style: Theme.of(context).textTheme.titleSmall),
      //Logo
      appLogo(
        height: responsiveHeight(80),
        width: responsiveWidth(320),
      ),
      //app version
      Text(packageInfo.version.toString(),
          style: Theme.of(context).textTheme.bodyMedium),
    ],
  );
}
