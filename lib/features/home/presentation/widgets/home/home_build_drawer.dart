import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/home/drawer/drawer_header.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/controllers/app_controller.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../auth/presentation/widgets/app_info_widget.dart';
import '../../controllers/home_controller.dart';
import '../dialogs/show_language_dialog.dart';
import '../dialogs/show_logout_confirmation.dart';

Widget homeBuildDrawer(BuildContext context, HomeController controller) {
  return Drawer(
    child: Obx(() => Column(children: [
          Expanded(
            child: ListView(children: [
              drawerHeader(controller.user.value.image,
                  controller.user.value.username, controller.user.value.email),
              ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('change_language'.tr),
                  onTap: () {
                    Get.back();
                    showLanguageDialog();
                  }),
              ListTile(
                leading: Icon(
                    Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Get.isDarkMode
                        ? AppColors.indigoAccentColor
                        : AppColors.amberColor[600]),
                title: Text('change_theme'.tr),
                trailing: Transform.scale(
                    scale: 1.2,
                    child: Switch(
                      value: Get.isDarkMode,
                      activeColor: AppColors.indigoAccentColor,
                      activeTrackColor: AppColors.indigoColor.withOpacity(0.4),
                      inactiveThumbColor: AppColors.amberColor[600],
                      inactiveTrackColor: AppColors.amberColor.withOpacity(0.4),
                      onChanged: (bool value) async {
                        await Get.find<AppController>().switchTheme(
                          themeMode: value ? ThemeMode.dark : ThemeMode.light,
                        );
                        HapticFeedback.lightImpact();
                      },
                    )),
                onTap: () async {
                  final newValue = !Get.isDarkMode;
                  await Get.find<AppController>().switchTheme(
                    themeMode: newValue ? ThemeMode.dark : ThemeMode.light,
                  );
                  HapticFeedback.lightImpact();
                },
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text('logout'.tr),
                onTap: () {
                  Get.back();
                  showLogoutConfirmation();
                },
              ),
            ]),
          ),
          appInfoWidget(context, controller.packageInfo.value),
          Gap(responsiveHeight(10))
        ])),
  );
}
