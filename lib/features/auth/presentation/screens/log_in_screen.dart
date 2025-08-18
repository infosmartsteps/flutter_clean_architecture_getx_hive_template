import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/lang_toggle_Button.dart';
import '../../../../core/widgets/theme_toggle_button.dart';
import '../controller/auth_controller.dart';
import '../widgets/app_info_widget.dart';
import '../widgets/log_in_form_widget.dart';
import '../widgets/wecome_text_widget.dart';

//lib/features/auth/presentation/screens/log_in_screen.dart
class LogInScreen extends GetView<AuthController> {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          appBar: AppBar(
              title: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: responsiveWidth(20)),
                  child: Row(spacing: responsiveWidth(10), children: [
                    languageToggleButton(),
                    themeToggleButton(),
                  ]))),
          body: ConstrainedBox(
            constraints: BoxConstraints(
                minHeight: displayHeight() - responsiveHeight(40)),
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: responsiveWidth(24)),
                child: SingleChildScrollView(
                    child: Obx(
                  () => SizedBox(
                    height: responsiveHeight(displayHeight()),
                    child: 
                  Column(children: [
                    Gap(responsiveHeight(40)),
                    welcomeTextWidget(context),
                    Gap(responsiveHeight(40)),
                    logInFormWidget(context, controller),
                    Gap(responsiveHeight(30)),
                    // Login Button
                    AppButton(
                      text: 'login'.tr,
                      onPressed: controller.onLogin,
                      isLoading: controller.isLoading.value,
                    ),
                    Spacer(),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child:
                          appInfoWidget(context, controller.packageInfo.value),
                    )
                  ]),
                  )
                ))),
          )),
    );
  }
}
