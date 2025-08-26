import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import '../../controllers/interested_clients_controller.dart';
import '../../widgets/interested_clients/opportunity_card.dart';

//lib/features/home/presentation/screens/home_screens/interested_clients_screen.dart
class InterestedClientsScreen extends GetView<InterestedClientsController> {
  const InterestedClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('interested_clients'.tr),
      ),
      body: Obx(
        () => controller.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : RefreshIndicator(
                onRefresh: () async {
                  await controller.getOpportunities();
                },
                child: ListView.separated(
                  separatorBuilder: (context, index) =>
                      Gap(responsiveHeight(15)),
                  padding: EdgeInsets.all(responsiveFont(16)),
                  itemCount: controller.opportunities.length,
                  itemBuilder: (context, index) {
                    return OpportunityCard(index: index);
                  },
                )),
      ),
    );
  }
}
