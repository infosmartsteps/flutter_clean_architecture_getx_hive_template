import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/available_opportunities_controller.dart';

class AvailableOpportunitiesBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AvailableOpportunitiesController>(
        AvailableOpportunitiesController());
  }
}
