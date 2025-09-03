import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';
import 'package:ksa_real_estates/core/constants/enums.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../controllers/home_controller.dart';
import '../widgets/home/home_build_body.dart';
import '../widgets/home/home_build_drawer.dart';

//lib/features/home/presentation/screens/home_screen.dart
class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('home'.tr), actions: [
        AppButton(
          type: AppButtonType.secondary,
          backgroundColor: AppColors.transparent,
          icon: Icon(Icons.notifications_outlined, size: responsiveFont(20)),
          onPressed: () {},
        ),
      ]),
      drawer: homeBuildDrawer(context, controller),
      body: homeBuildBody(context),
    );
  }
}
