import 'dart:math';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/app_colors.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/enums.dart';
import '../../../../core/widgets/app_button.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(controller.errorMessage.value, textAlign: TextAlign.center),
              Gap(responsiveHeight(10)),
              ElevatedButton(
                onPressed: controller.checkLocationPermission,
                child: const Text('Retry'),
              ),
            ],
          ),
        );
      }
      return FlutterMap(
        mapController: controller.mapController.value,
        options: MapOptions(
          initialCenter: controller.currentLocation.value,
          initialZoom: controller.zoom.value,
          onTap: onTap,
          onMapReady: onMapReady,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: const ['a', 'b', 'c'],
            userAgentPackageName: 'com.example.flutter_map_example',
            tileProvider: CancellableNetworkTileProvider(),
          ),
          if (controller.locationPermissionGranted.value)
            CurrentLocationLayer(),
          MarkerLayer(
            alignment: Alignment.topCenter,
            markers: [controller.locationMarker.value],
          ),
        ],
      );
    });
  }
}



/*
class MapScreen extends GetView<MapGetXController> {
  const MapScreen({super.key});

  Widget _buildMap() {
    if (controller.isLoading.value) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(controller.errorMessage.value, textAlign: TextAlign.center),
            Gap(responsiveHeight(10)),
            ElevatedButton(
              onPressed: controller.checkLocationPermission,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return FlutterMap(
      mapController: controller.mapController.value,
      options: MapOptions(
        initialCenter: controller.currentLocation.value,
        initialZoom: controller.zoom.value,
        onTap: (tapPosition, point) {
          controller.currentLocation.value =
              LatLng(point.latitude, point.longitude);
          controller.update();
        },
        onMapReady: () {
          controller.isMapReady.value = true;
          controller.update();
          controller.getCurrentLocation();
          controller.update();

          controller.mapController.value
              .move(controller.currentLocation.value, controller.zoom.value);
        },
      ),
      children: [
        // OpenStreetMap Tile Layer
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          subdomains: const ['a', 'b', 'c'],
          userAgentPackageName: 'com.example.flutter_map_example',
          tileProvider: CancellableNetworkTileProvider(),
        ),

        // Location Marker Layer
        if (controller.locationPermissionGranted.value)
          CurrentLocationLayer(
              // alignPositionOnUpdate: AlignOnUpdate.always,
              // alignDirectionOnUpdate: AlignOnUpdate.never,
              ),

        // Marker for current location (fallback)
        MarkerLayer(
          alignment: Alignment.topCenter,
          markers: [
            Marker(
              alignment: Alignment.topCenter,
              point: controller.currentLocation.value,
              width: responsiveWidth(!(controller.isShowFlag.value &&
                      (Get.arguments != null && Get.arguments != ''))
                  ? 40
                  : 70),
              height: responsiveHeight(!(controller.isShowFlag.value &&
                      (Get.arguments != null && Get.arguments != ''))
                  ? 40
                  : 67),
              child: InkWell(
                onTap: controller.toggleFlag,
                child: controller.isShowFlag.value &&
                        (Get.arguments != null && Get.arguments != '')
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              color: Colors.black,
                              child: Text(Get.arguments,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(Get.context!)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColors.whiteColor))),
                          Icon(
                            Icons.location_history_rounded,
                            color: Colors.red,
                            size: responsiveFont(30),
                          ),
                        ],
                      )
                    : Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: responsiveFont(30),
                      ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: AppBar(
            title: Text('choose_Location'.tr),
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            actions: [
              AppButton(
                  type: AppButtonType.secondary,
                  onPressed: controller.saveLocation,
                  icon: Icon(Icons.save, color: Colors.green),
                  text: "${'save'.tr}   "),
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: controller.refreshLocation,
              ),
            ],
          ),
          body: _buildMap(),
          floatingActionButton: controller.isMapReady.value
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Spacer(),
                    FlutterMapZoomButtons(),
                    Spacer(),
                    FloatingActionButton(
                      onPressed: () => controller.mapController.value.move(
                          controller.currentLocation.value,
                          controller.zoom.value),
                      child: const Icon(
                        Icons.location_pin,
                        color: Colors.red,
                      ),
                    ),
                    Gap(responsiveHeight(15)),
                    FloatingActionButton(
                      onPressed: () => controller.getCurrentLocation(),
                      child: const Icon(Icons.my_location),
                    )
                  ],
                )
              : null,
        ));
  }
}

class FlutterMapZoomButtons extends GetView<MapGetXController> {
  final double minZoom;
  final double maxZoom;
  final bool mini;
  final double padding;
  final Alignment alignment;
  final Color? zoomInColor;
  final Color? zoomInColorIcon;
  final Color? zoomOutColor;
  final Color? zoomOutColorIcon;
  final IconData zoomInIcon;
  final IconData zoomOutIcon;

  const FlutterMapZoomButtons({
    super.key,
    this.minZoom = 6,
    this.maxZoom = 18,
    this.mini = true,
    this.padding = 2.0,
    this.alignment = Alignment.topRight,
    this.zoomInColor,
    this.zoomInColorIcon,
    this.zoomInIcon = Icons.zoom_in,
    this.zoomOutColor,
    this.zoomOutColorIcon,
    this.zoomOutIcon = Icons.zoom_out,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Align(
      alignment: alignment,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding:
                EdgeInsets.only(left: padding, top: padding, right: padding),
            child: FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: mini,
              backgroundColor: zoomInColor ?? theme.primaryColor,
              onPressed: () {
                final zoom = min(
                    controller.mapController.value.camera.zoom + 1, maxZoom);
                controller.mapController.value
                    .move(controller.mapController.value.camera.center, zoom);
              },
              child: Icon(zoomInIcon,
                  color: zoomInColorIcon ?? theme.iconTheme.color),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(padding),
            child: FloatingActionButton(
              heroTag: 'zoomOutButton',
              mini: mini,
              backgroundColor: zoomOutColor ?? theme.primaryColor,
              onPressed: () {
                final zoom = max(
                    controller.mapController.value.camera.zoom - 1, minZoom);
                controller.mapController.value
                    .move(controller.mapController.value.camera.center, zoom);
              },
              child: Icon(zoomOutIcon,
                  color: zoomOutColorIcon ?? theme.iconTheme.color),
            ),
          ),
        ],
      ),
    );
  }
}

 */
