import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import 'client/client_details_card.dart';
import 'information_screens_header.dart';
import 'map_widget.dart';

//lib/features/home/presentation/widgets/interested_clients/client_information_screen.dart
class ClientInformationScreen extends GetView<InterestedClientsController> {
  const ClientInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ClientEntity client = Get.arguments['client'];
    final isPhone =
        client.phoneNumber != null && client.phoneNumber!.isNotEmpty;
    final isEmail = client.email != null && client.email!.isNotEmpty;
    return Scaffold(
        appBar: AppBar(title: Text('client_information'.tr)),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(responsiveFont(16)),
          child: Column(
              spacing: responsiveHeight(30),
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                informationScreensHeader(
                    title: client.clientName ?? '',
                    subtitle: 'potential_client'.tr,
                    icon: Icons.person),
                clientDetailsCard(client),
                MapWidget(label: 'client_location'.tr),
                // Action Buttons
                if (isPhone && isEmail)
                  Row(children: [
                    if (isEmail) ...[
                      Expanded(
                          child: AppButton(
                              onPressed: () => controller.launchEmail(
                                  mailtoUrl: client.email ?? ''),
                              icon: Icon(Icons.email, size: responsiveFont(20)),
                              text: 'email'.tr)),
                      SizedBox(width: responsiveWidth(12)),
                    ],
                    if (isPhone)
                      Expanded(
                          child: AppButton(
                              onPressed: () => controller
                                  .callCustomer(client.phoneNumber ?? ''),
                              icon: Icon(Icons.phone, size: responsiveFont(20)),
                              text: 'call'.tr)),
                  ]),
              ]),
        ));
  }
}
