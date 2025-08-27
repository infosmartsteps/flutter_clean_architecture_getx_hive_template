import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/dialogs/location_info_dialog.dart';
import '../../../../../core/utils/responsive_size_helper.dart';
import '../../../../../core/widgets/app_button.dart';
import '../flutter_map_widget.dart';

class MapWidget extends GetView<InterestedClientsController> {
  final String label;

  const MapWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: responsiveHeight(12),
        children: [
          Text(label, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(
              height: responsiveHeight(200),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(responsiveFont(12)),
                  child: Scaffold(
                    body: FlutterMapWidget(),
                    floatingActionButton: FloatingActionButton(
                        onPressed: () => showLocationInfoDialog(),
                        child: const Icon(Icons.info)),
                  ))),
          // Action Buttons
          Row(children: [
            Expanded(
              child: AppButton(
                  onPressed: controller.openNativeMap,
                  icon: Icon(Icons.map_outlined,
                      size: responsiveFont(20),
                      color: Get.theme.colorScheme.onPrimary),
                  text: 'open_in_maps'.tr),
            ),
            SizedBox(width: responsiveWidth(12)),
            Expanded(
                child: AppButton(
                    onPressed: controller.shareLocation,
                    icon: Icon(Icons.share,
                        size: responsiveFont(20),
                        color: Theme.of(context).colorScheme.onPrimary),
                    text: 'share'.tr)),
          ]),
        ]);
  }
}
