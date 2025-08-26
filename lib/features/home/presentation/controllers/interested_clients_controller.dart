import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:latlong2/latlong.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../domain/entities/opportunity.dart';

//lib/features/home/presentation/controllers/interested_clients_controller.dart
class InterestedClientsController extends GetxController {
  final RxList<Opportunity> opportunities = <Opportunity>[].obs;
  final RxBool isLoading = true.obs;

  Future<void> getOpportunities() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));
    opportunities.assignAll([
      Opportunity(
        id: "OP-2023-00125",
        propertyName: "برج الإمارات",
        unitName: "شقة 305 - الطابق الثالث",
        propertyLink: "https://example.com/property/123",
        clientName: "أحمد محمد السعدي",
        clientLink: "https://example.com/client/456",
        propertyLocation: LatLng(31.986040, 35.879221),
        clientLocation: LatLng(31.963158, 35.930359),
      ),
      Opportunity(
        id: "OP-2023-00126",
        propertyName: "مجمع الرياض السكني",
        unitName: "فيلا 12 - قطعة 7",
        propertyLink: "https://example.com/property/124",
        clientName: "سارة عبدالله الفهد",
        clientLink: "https://example.com/client/457",
        isFollowed: true,
        propertyLocation: LatLng(31.986040, 35.879221),
        clientLocation: LatLng(31.963158, 35.930359),
      ),
      Opportunity(
        id: "OP-2023-00127",
        propertyName: "مشروع النخيل",
        unitName: "متجر 45 - الطابق الأرضي",
        propertyLink: "https://example.com/property/125",
        clientName: "شركة التقنية المحدودة",
        clientLink: "https://example.com/client/458",
        propertyLocation: LatLng(31.986040, 35.879221),
        clientLocation: LatLng(31.963158, 35.930359),
      ),
    ]);
    isLoading.value = false;
  }

  Future<void> initialize() async {
    await getOpportunities();
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    initialize();
  }

  void toggleFollow(int index) {
    final updatedOpportunity = opportunities[index].copyWith(
      isFollowed: !opportunities[index].isFollowed,
    );
    opportunities[index] = updatedOpportunity;

    Get.snackbar(
      updatedOpportunity.isFollowed ? "success".tr : "canceled".tr,
      updatedOpportunity.isFollowed
          ? "Follow-up_Completed".tr
          : "Follow-up_Canceled".tr,
      duration: const Duration(seconds: 1),
      snackPosition: SnackPosition.BOTTOM,
      icon: updatedOpportunity.isFollowed
          ? Icon(Icons.check_circle)
          : Icon(Icons.remove_circle),
      backgroundColor: updatedOpportunity.isFollowed
          ? Colors.green
          : Get.theme.colorScheme.onPrimary,
    );

    // Here you would typically make API call to update the backend
  }

  void goToInformationScreen(String page, int index) async {
    Get.toNamed(page, arguments: {'index': index, "label": "123"});
  }

  Future<void> shareLocation(BuildContext context) async {
    LatLng point = LatLng(0, 0);
    if (Get.routing.current == AppRoutes.propertyInformationScreen) {
      point = opportunities[Get.arguments['index']].propertyLocation;
    } else if (Get.routing.current == AppRoutes.clientInformationScreen) {
      point = opportunities[Get.arguments['index']].clientLocation;
    }
    String mapUrl;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      mapUrl =
          'https://maps.apple.com/?q=${point.latitude},${point.longitude}&z=15&t=m';
    } else {
      mapUrl =
          'https://www.google.com/maps/search/?api=1&query=${point.latitude},${point.longitude}&query_place_id=Googleplex';
    }

    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(ShareParams(
      text: mapUrl,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    ));
  }

  // Function to open maps with the specified coordinates
  Future<void> openMap() async {
    LatLng point = LatLng(0, 0);
    if (Get.routing.current == AppRoutes.propertyInformationScreen) {
      point = opportunities[Get.arguments['index']].propertyLocation;
    } else if (Get.routing.current == AppRoutes.clientInformationScreen) {
      point = opportunities[Get.arguments['index']].clientLocation;
    }
    final String mapUrl =
        'https://www.google.com/maps/search/?api=1&query=${point.latitude},${point.longitude}&query_place_id=Googleplex';

    if (await canLaunchUrl(Uri.parse(mapUrl))) {
      await launchUrl(Uri.parse(mapUrl));
    } else {
      throw 'Could not launch $mapUrl';
    }
  }

  // Function to open Apple Maps (on iOS) or Google Maps (on Android)
  Future<void> openNativeMap(BuildContext context) async {
    LatLng point = LatLng(0, 0);
    if (Get.routing.current == AppRoutes.propertyInformationScreen) {
      point = opportunities[Get.arguments['index']].propertyLocation;
    } else if (Get.routing.current == AppRoutes.clientInformationScreen) {
      point = opportunities[Get.arguments['index']].clientLocation;
    }
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      String url =
          'https://maps.apple.com/?q=${point.latitude},${point.longitude}&z=15&t=m';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback to Google Maps in browser
        final String fallbackUrl =
            'https://www.google.com/maps/search/?api=1&query=${point.latitude},${point.longitude}';
        if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
          await launchUrl(Uri.parse(fallbackUrl));
        } else {
          throw 'Could not launch maps';
        }
      }
    } else {
      // url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving&dir_action=navigate';
      openMap();
    }
  }

  Future<void> callCustomer(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  void launchEmail({required String mailtoUrl}) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: mailtoUrl,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }
}
