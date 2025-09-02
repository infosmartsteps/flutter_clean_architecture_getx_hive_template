import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/my_opportunities_controller.dart';
import '../../../../../core/constants/routes/app_routes.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../domain/entities/opportunity_entity.dart';
import '../interested_clients/opportunity_card.dart';

class OpportunityListView extends GetView<MyOpportunitiesController> {
  const OpportunityListView({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildOpportunityList();
  }

  Widget _buildOpportunityList() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      return RefreshIndicator(
        onRefresh: controller.getMyOpportunities,
        child: ListView.separated(
            separatorBuilder: (context, index) => Gap(responsiveHeight(15)),
            padding: EdgeInsets.all(responsiveFont(16)),
            itemCount: controller.opportunities.length,
            itemBuilder: (_, index) => _buildOpportunityCard(index)),
      );
    });
  }

  Widget _buildOpportunityCard(int index) {
    final opportunity = controller.opportunities[index];

    return OpportunityCard(
      opportunity: opportunity,
      goToClientInformationScreen: controller.goToClientInformationScreen,
      goToPropertyInformationScreen: controller.goToPropertyInformationScreen,
      completion: () => _navigateToOpportunityInfo(opportunity, 'completion'),
      abandonment: () => _navigateToOpportunityInfo(opportunity, 'abandonment'),
      cancel: () => _navigateToOpportunityInfo(opportunity, 'cancel'),
    );
  }

  void _navigateToOpportunityInfo(
      OpportunityEntity opportunity, String action) {
    Get.toNamed(
      AppRoutes.opportunityInformationScreen,
      arguments: {'opportunity': opportunity, 'from': action},
    );
  }
}
