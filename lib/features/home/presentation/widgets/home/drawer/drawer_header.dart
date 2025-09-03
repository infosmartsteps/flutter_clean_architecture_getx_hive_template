import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/constants/app_colors.dart';
import '../../../../../../core/utils/responsive_size_helper.dart';
import 'package:cached_network_image/cached_network_image.dart';

Widget drawerHeader(image, name, email) {
  return DrawerHeader(
    decoration: BoxDecoration(color: Get.theme.colorScheme.primary),
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            radius: responsiveFont(30),
            backgroundColor:AppColors.whiteColor,
            child: CachedNetworkImage(
                imageUrl: image ?? '',
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (ct, url, er) => Icon(Icons.person)),
          ),
          Text(name ?? '',
              style: Get.theme.textTheme.titleLarge
                  ?.copyWith(color:AppColors.whiteColor)),
          Text(email ?? '',
              style: Get.theme.textTheme.bodyMedium
                  ?.copyWith(color:AppColors.whiteColor)),
        ]),
  );
}
