import 'package:flutter/material.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import 'package:get/get.dart';
import '../../widgets/home/home_build_option_card.dart';

//lib/features/home/presentation/screens/home_screens/my_previous_operations_screen.dart
class MyPreviousOperationsScreen extends StatelessWidget {
  const MyPreviousOperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('my_previous_operations'.tr)),
        body: Padding(
          padding: EdgeInsets.all(responsiveWidth(16)),
          child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: responsiveWidth(16),
              mainAxisSpacing: responsiveHeight(16),
              children: [
                homeBuildOptionCard(
                  icon: Icons.people_outline,
                  title: 'entered_clients'.tr,
                  color: Colors.blue,
                  onTap: () => Get.toNamed(AppRoutes.enteredClientsScreen),
                ),
                homeBuildOptionCard(
                  icon: Icons.business_sharp,
                  title: 'entered_opportunities'.tr,
                  color: Colors.orange,
                  onTap: () =>
                      Get.toNamed(AppRoutes.enteredOpportunitiesScreen),
                )
              ]),
        ));
  }
}
