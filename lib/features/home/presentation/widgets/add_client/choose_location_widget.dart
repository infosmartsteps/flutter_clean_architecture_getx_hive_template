import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../controllers/map_get_x_controller.dart';
import '../flutter_map_widget.dart';
import 'flutter_map_zoom_buttons.dart';

//lib/features/home/presentation/widgets/add_client/choose_location_widget.dart
class ChooseLocationScreen extends GetView<MapGetXController> {
  const ChooseLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
            title: Text('choose_Location'.tr),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              if (controller.isMapReady.value)
                AppButton(
                    type: AppButtonType.secondary,
                    onPressed: controller.saveLocation,
                    icon: Icon(Icons.save, color: Colors.green),
                    text: "${'save'.tr}   "),
              IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: controller.refreshLocation),
            ]),
        body: FlutterMapWidget(
            onTap: (tapPosition, point) => controller.setCurrentLocation(point),
            onMapReady: controller.onMapReady),
        floatingActionButton: controller.isMapReady.value
            ? Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                    Spacer(),
                    FlutterMapZoomButtons(),
                    Spacer(),
                    FloatingActionButton(
                        heroTag: 'location_pin',
                        onPressed: () => controller.mapController.value.move(
                            controller.currentLocation.value,
                            controller.zoom.value),
                        child:
                            const Icon(Icons.location_pin, color: Colors.red)),
                    Gap(responsiveHeight(15)),
                    FloatingActionButton(
                        heroTag: 'my_location',
                        onPressed: () => controller.getCurrentLocation(),
                        child: const Icon(Icons.my_location))
                  ])
            : null));
  }
}
