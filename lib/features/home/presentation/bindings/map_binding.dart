import 'package:get/get.dart';

import '../controllers/map_get_x_controller.dart';

class MapBinding extends Bindings {
  final bool isLive;

  MapBinding({this.isLive = false});

  @override
  void dependencies() {
    Get.put<MapGetXController>(MapGetXController(isLive: isLive));
  }
}
