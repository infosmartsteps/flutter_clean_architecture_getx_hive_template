import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/enums.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/core/widgets/app_button.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter/material.dart';
import '../controllers/map_get_x_controller.dart';

//lib/features/home/presentation/widgets/flutter_map_widget.dart
class FlutterMapWidget extends GetView<MapGetXController> {
  final void Function(TapPosition, LatLng)? onTap;
  final void Function()? onMapReady;

  const FlutterMapWidget({super.key, this.onTap, this.onMapReady});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.isNotEmpty) {
        return Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(controller.errorMessage.value, textAlign: TextAlign.center),
            Gap(responsiveHeight(10)),
            AppButton(
              backgroundColor: Get.theme.colorScheme.primary,
              type: AppButtonType.secondary,
                onPressed: controller.checkLocationPermission,
                text: 'Retry'),
          ]),
        );
      }

      return FlutterMap(
          mapController: controller.mapController.value,
          options: MapOptions(
            initialCenter: controller.currentLocation.value,
            initialZoom: controller.zoom.value,
            onTap: onTap,
            onMapReady: onMapReady,
            interactionOptions: controller.interactionOption.value
          ),
          children: [
            TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.flutter_map_example',
                tileProvider: CancellableNetworkTileProvider()),
            if (controller.locationPermissionGranted.value)
              CurrentLocationLayer(),
            MarkerLayer(
                alignment: Alignment.topCenter,
                markers: [controller.locationMarker.value]),
          ]);
    });
  }
}
