import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';

class InterestedClientsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<InterestedClientsController>(InterestedClientsController());
  }
}
