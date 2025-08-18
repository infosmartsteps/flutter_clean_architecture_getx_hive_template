import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/data/local/storage_helper.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/controllers/app_controller.dart';
import '../../../../core/localization/translations/translation_service.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../auth/presentation/widgets/app_info_widget.dart';
import '../controllers/home_controller.dart';

//lib/features/home/presentation/screens/home_screen.dart
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('home'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      drawer: _buildDrawer(context),
      body: buildBody(context),
    );
  }

  Widget _buildDrawer(BuildContext context) {
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
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                  ),
                        ),
                        Text(
                          controller.user.value.email ?? '',
                          style:
                              Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                  // ListTile(
                  //   leading: const Icon(Icons.brightness_6_outlined,
                  //       color: Colors.deepPurple),
                  //   title: Text('change_theme'.tr,
                  //       style: TextStyle(fontWeight: FontWeight.w500)),
                  //   onTap: () async {
                  //     Get.dialog(
                  //       AlertDialog(
                  //         title: Text('select_theme'.tr,
                  //             style: TextStyle(
                  //                 fontSize: 18, fontWeight: FontWeight.bold)),
                  //         content: Column(
                  //           mainAxisSize: MainAxisSize.min,
                  //           children: [
                  //             ListTile(
                  //               trailing: Get.isDarkMode
                  //                   ? Icon(Icons.check, color: Colors.green)
                  //                   : null,
                  //               title: Text("dark".tr),
                  //               leading:
                  //                   Icon(Icons.dark_mode, color: Colors.indigo),
                  //               onTap: Get.isDarkMode
                  //                   ? null
                  //                   : () async {
                  //                       await Get.find<AppController>()
                  //                           .switchTheme(
                  //                               themeMode: ThemeMode.dark);
                  //                       Get.back();
                  //                     },
                  //             ),
                  //             Divider(height: 1, color: Colors.grey[300]),
                  //             ListTile(
                  //               trailing: !Get.isDarkMode
                  //                   ? Icon(Icons.check, color: Colors.green)
                  //                   : null,
                  //               title: Text("light".tr),
                  //               leading:
                  //                   Icon(Icons.light_mode, color: Colors.amber),
                  //               onTap: !Get.isDarkMode
                  //                   ? null
                  //                   : () async {
                  //                       await Get.find<AppController>()
                  //                           .switchTheme(
                  //                               themeMode: ThemeMode.light);
                  //                       Get.back();
                  //                     },
                  //             ),
                  //           ],
                  //         ),
                  //         actions: [
                  //           TextButton(
                  //             child: Text('cancel'.tr,
                  //                 style: Theme.of(context)
                  //                     .textTheme
                  //                     .bodyMedium
                  //                     ?.copyWith(
                  //                         decoration:
                  //                             TextDecoration.underline)),
                  //             onPressed: () => Get.back(),
                  //           ),
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  ListTile(
                    leading: Icon(
                      Get.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                      color: Get.isDarkMode ? Colors.indigoAccent : Colors.amber[600],
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

  Widget buildBody(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(responsiveWidth(16)),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: responsiveWidth(16),
        mainAxisSpacing: responsiveHeight(16),
        children: [
          _buildOptionCard(
            context,
            icon: Icons.person_add_alt_1_outlined,
            title: 'new_client'.tr,
            color: Colors.blue,
            onTap: () {
              // Handle new client option
            },
          ),
          _buildOptionCard(
            context,
            icon: Icons.people_outline,
            title: 'interested_clients'.tr,
            color: Colors.green,
            onTap: () {
              // Handle interested clients option
            },
          ),
          _buildOptionCard(
            context,
            icon: Icons.business_outlined,
            title: 'available_opportunities'.tr,
            color: Colors.orange,
            onTap: () {
              // Handle available opportunities option
            },
          ),
          _buildOptionCard(
            context,
            icon: Icons.work_outline,
            title: 'my_opportunities'.tr,
            color: Colors.purple,
            onTap: () {
              // Handle my opportunities option
            },
          ),
          _buildOptionCard(
            context,
            icon: Icons.history_outlined,
            title: 'my_previous_operations'.tr,
            color: Colors.red,
            onTap: () {
              // Handle previous operations option
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOptionCard(
    BuildContext context, {
    required IconData icon,
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(responsiveWidth(16)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: responsiveHeight(10),
            children: [
              Container(
                padding: EdgeInsets.all(responsiveWidth(12)),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: responsiveFont(30),
                  color: color,
                ),
              ),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLanguageDialog() {
    Get.dialog(AlertDialog(
      title: Text('select_language'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            trailing:
                Get.locale == LanguageLocals.english ? Icon(Icons.check) : null,
            title: const Text(Languages.english),
            leading: const Icon(Icons.language),
            onTap: Get.locale == LanguageLocals.english
                ? null
                : () async {
                    await TranslationService.changeLocale(
                        LanguageLocals.english);
                    Get.back();
                  },
          ),
          ListTile(
            trailing:
                Get.locale == LanguageLocals.arabic ? Icon(Icons.check) : null,
            title: const Text(Languages.arabic),
            leading: Icon(Icons.language),
            onTap: Get.locale == LanguageLocals.arabic
                ? null
                : () async {
                    await TranslationService.changeLocale(
                        LanguageLocals.arabic);
                    Get.back();
                  },
          ),
        ],
      ),
    ));
  }

  void showLogoutConfirmation() {
    Get.dialog(AlertDialog(
      title: Text('logout'.tr),
      content: Text('are_you_sure_logout'.tr),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: Text('cancel'.tr),
        ),
        TextButton(
          onPressed: () async {
            //remove user data from hive using storage helper
            await StorageHelper().logout();
            Get.back();
            Get.offNamed(AppRoutes.logInScreen);
          },
          child: Text('logout'.tr),
        ),
      ],
    ));
  }
}
