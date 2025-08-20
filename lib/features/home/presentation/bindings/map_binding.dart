import 'package:get/get.dart';

import '../controllers/map_get_x_controller.dart';

class MapBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<MapGetXController>(MapGetXController());
  }
}
