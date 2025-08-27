import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/map_get_x_controller.dart';

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
      child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: padding, top: padding, right: padding),
          child: FloatingActionButton(
            heroTag: 'zoomInButton',
            mini: mini,
            backgroundColor: zoomInColor ?? theme.primaryColor,
            onPressed: () {
              final zoom =
                  min(controller.mapController.value.camera.zoom + 1, maxZoom);
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
              final zoom =
                  max(controller.mapController.value.camera.zoom - 1, minZoom);
              controller.mapController.value
                  .move(controller.mapController.value.camera.center, zoom);
            },
            child: Icon(zoomOutIcon,
                color: zoomOutColorIcon ?? theme.iconTheme.color),
          ),
        ),
      ]),
    );
  }
}
