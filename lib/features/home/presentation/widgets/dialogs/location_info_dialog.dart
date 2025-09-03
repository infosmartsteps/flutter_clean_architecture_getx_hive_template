import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../controllers/map_get_x_controller.dart';

void showLocationInfoDialog() {
  final controller = Get.find<MapGetXController>();
  Get.defaultDialog(
      title: "Location Info",
      content: Column(
          spacing: responsiveHeight(10),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('Country: ${controller.place.country}'),
            Text('City: ${controller.place.locality}'),
            Text('SubLocality: ${controller.place.subLocality}'),
            Text('Street: ${controller.place.street}'),
            if (controller.place.postalCode != null &&
                controller.place.postalCode!.isNotEmpty)
              Text('Postal Code: ${controller.place.postalCode}'),
            Text('latitude: ${controller.currentLocation.value.latitude}'),
            Text('longitude: ${controller.currentLocation.value.longitude}'),
          ]));
}
