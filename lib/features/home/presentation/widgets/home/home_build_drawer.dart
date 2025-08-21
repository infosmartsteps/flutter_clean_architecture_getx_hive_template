import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../../core/controllers/app_controller.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../auth/presentation/widgets/app_info_widget.dart';
import '../../controllers/home_controller.dart';
import '../../screens/home_screen.dart';
import '../dialogs/show_language_dialog.dart';
import '../dialogs/show_logout_confirmation.dart';

Widget homeBuildDrawer(BuildContext context, HomeController controller) {
  return Drawer(
    child: Obx(
          () => Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        radius: responsiveFont(30),
                        backgroundColor: Colors.white,
                        child: CachedNetworkImage(
                          imageUrl: controller.user.value.image ?? '',
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                              CircularProgressIndicator(
                                  value: downloadProgress.progress),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.person),
                        ),
                      ),
                      Text(
                        controller.user.value.username ?? '',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        controller.user.value.email ?? '',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('change_language'.tr),
                  onTap: () {
                    Get.back();
                    showLanguageDialog();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                    color: Get.isDarkMode
                        ? Colors.indigoAccent
                        : Colors.amber[600],
                  ),
                  title: Text(
                    'change_theme'.tr,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.titleMedium?.color,
                    ),
                  ),
                  trailing: Transform.scale(
                    scale: 1.2,
                    child: Switch(
                      value: Get.isDarkMode,
                      activeColor: Colors.indigoAccent,
                      activeTrackColor: Colors.indigo.withOpacity(0.4),
                      inactiveThumbColor: Colors.amber[600],
                      inactiveTrackColor: Colors.amber.withOpacity(0.4),
                      onChanged: (bool value) async {
                        await Get.find<AppController>().switchTheme(
                          themeMode: value ? ThemeMode.dark : ThemeMode.light,
                        );
                        // Optional: Add haptic feedback
                        HapticFeedback.lightImpact();
                      },
                    ),
                  ),
                  onTap: () async {
                    // Allow tap on the whole tile to toggle the switch
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
              ],
            ),
          ),
          appInfoWidget(context, controller.packageInfo.value),
          Gap(responsiveHeight(10))
        ],
      ),
    ),
  );
}