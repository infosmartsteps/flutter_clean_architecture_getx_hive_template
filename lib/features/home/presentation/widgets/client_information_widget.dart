import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:latlong2/latlong.dart';
import 'interested_clients/client/client_details_card.dart';
import 'interested_clients/information_screens_header.dart';

Widget clientInformationWidget(client) {
  return Column(children: [
    informationScreensHeader(
        title: client.clientName ?? '',
        subtitle: 'potential_client'.tr,
        icon: Icons.person),
    clientDetailsCard(
      client,
      clientDataLink: 'Client_information_Link'.tr,
      onTap: () {
        Get.toNamed(AppRoutes.clientInformationScreen, arguments: {
          'client': client,
          'point': LatLng(
              client.clientLocationLat ?? 0, client.clientLocationLng ?? 0)
        });
      },
    ),
  ]);
}
