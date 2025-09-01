import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:ksa_real_estates/core/utils/responsive_size_helper.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import 'package:latlong2/latlong.dart';
import '../interested_clients/client/client_details_card.dart';
import '../interested_clients/information_screens_header.dart';

Widget clientsListView(List<ClientEntity> clients) {
  return ListView.separated(
    separatorBuilder: (context, index) => Gap(responsiveHeight(10)),
    itemCount: clients.length,
    itemBuilder: (context, index) {
      final client = clients[index];
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
    },
  );
}
