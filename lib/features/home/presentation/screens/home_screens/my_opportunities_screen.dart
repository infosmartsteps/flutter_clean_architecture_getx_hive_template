import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/my_opportunities_controller.dart';
import '../../widgets/my_opportunities/filter_opportunities_button.dart';
import '../../widgets/my_opportunities/opportunity_list_view.dart';

// lib/features/home/presentation/screens/home_screens/my_opportunities_screen.dart
class MyOpportunitiesScreen extends GetView<MyOpportunitiesController> {
  const MyOpportunitiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('my_opportunities'.tr),
        actions: [FilterOpportunitiesButton()],
      ),
      body: OpportunityListView(),
    );
  }
}
