import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import '../../controllers/map_get_x_controller.dart';

class FlutterMapZoomButtons extends GetView<MapGetXController> {
  final double minZoom, maxZoom;
  final IconData zoomInIcon, zoomOutIcon;
  final Alignment alignment;

  const FlutterMapZoomButtons(
      {super.key,
      this.minZoom = 6,
      this.maxZoom = 18,
      this.alignment = Alignment.topRight,
      this.zoomInIcon = Icons.zoom_in,
      this.zoomOutIcon = Icons.zoom_out});

  @override
  Widget build(BuildContext context) {
    return Column(
        spacing: responsiveHeight(10),
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FloatingActionButton(
              heroTag: 'zoomInButton',
              mini: true,
              backgroundColor: Get.theme.primaryColor,
              onPressed: () {
                final zoom = min(
                    controller.mapController.value.camera.zoom + 1, maxZoom);
                controller.mapController.value
                    .move(controller.mapController.value.camera.center, zoom);
              },
              child: Icon(zoomInIcon, color: Get.theme.iconTheme.color)),
          FloatingActionButton(
            heroTag: 'zoomOutButton',
            mini: true,
            backgroundColor: Get.theme.primaryColor,
            onPressed: () {
              final zoom =
                  max(controller.mapController.value.camera.zoom - 1, minZoom);
              controller.mapController.value
                  .move(controller.mapController.value.camera.center, zoom);
            },
            child: Icon(zoomOutIcon, color: Get.theme.iconTheme.color),
          ),
        ]);
  }
}
