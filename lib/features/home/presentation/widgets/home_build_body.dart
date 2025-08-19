import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../../../../core/widgets/app_text_form_field.dart';
import '../screens/home_screens/add_client_screen.dart';
import 'home_build_option_card.dart';

Widget homeBuildBody(BuildContext context) {
  return Padding(
    padding: EdgeInsets.all(responsiveWidth(16)),
    child: GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: responsiveWidth(16),
      mainAxisSpacing: responsiveHeight(16),
      children: [
        homeBuildOptionCard(
          context,
          icon: Icons.person_add_alt_1_outlined,
          title: 'new_client'.tr,
          color: Colors.blue,
          onTap: () {
            Get.toNamed(AppRoutes.addClientForm);
          },
        ),
        homeBuildOptionCard(
          context,
          icon: Icons.people_outline,
          title: 'interested_clients'.tr,
          color: Colors.green,
          onTap: () {
            // Handle interested clients option
          },
        ),
        homeBuildOptionCard(
          context,
          icon: Icons.business_outlined,
          title: 'available_opportunities'.tr,
          color: Colors.orange,
          onTap: () {
            // Handle available opportunities option
          },
        ),
        homeBuildOptionCard(
          context,
          icon: Icons.work_outline,
          title: 'my_opportunities'.tr,
          color: Colors.purple,
          onTap: () {
            // Handle my opportunities option
          },
        ),
        homeBuildOptionCard(
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
