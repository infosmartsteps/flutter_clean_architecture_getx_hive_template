import 'dart:math';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:flutter/material.dart';
import '../../../../../core/constants/enums.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../controllers/map_get_x_controller.dart';
import '../flutter_map_widget.dart';

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
            onPressed: controller.refreshLocation,
          ),
        ],
      ),
      body: FlutterMapWidget(
        onTap: (tapPosition, point) {
          controller.setCurrentLocation(point);
        },
        onMapReady: () {
          controller.isMapReady.value = true;
          controller.update();
          controller.initialization();
          controller.update();

          controller.mapController.value.move(
              controller.currentLocation.value, controller.zoom.value);
        },
      ),
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