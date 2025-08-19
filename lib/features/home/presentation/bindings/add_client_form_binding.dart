import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';

import '../controllers/home_controller.dart';

class AddClientFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AddClientFormController>(AddClientFormController());
  }
}
