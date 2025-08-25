import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

//lib/features/home/presentation/controllers/interested_clients_controller.dart
class InterestedClientsController extends GetxController {
  final RxList<Opportunity> opportunities = <Opportunity>[].obs;
  final RxBool isLoading = true.obs;

  Future<void> initialize() async {
    await getOpportunities();
  }

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
      ),
      Opportunity(
        id: "OP-2023-00126",
        propertyName: "مجمع الرياض السكني",
        unitName: "فيلا 12 - قطعة 7",
        propertyLink: "https://example.com/property/124",
        clientName: "سارة عبدالله الفهد",
        clientLink: "https://example.com/client/457",
        isFollowed: true,
      ),
      Opportunity(
        id: "OP-2023-00127",
        propertyName: "مشروع النخيل",
        unitName: "متجر 45 - الطابق الأرضي",
        propertyLink: "https://example.com/property/125",
        clientName: "شركة التقنية المحدودة",
        clientLink: "https://example.com/client/458",
      ),
    ]);
    isLoading.value = false;
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

  void openLink(String page) {
    Get.toNamed(page);
  }

  Future<void> shareProperty(
      Opportunity opportunity, BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    await SharePlus.instance.share(ShareParams(
      text: opportunity.propertyLink,
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    ));
  }
  // Function to open maps with the specified coordinates
  Future<void> openMap(double lat, double lng, String locationLabel) async {
    final String mapUrl =
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng&query_place_id=$locationLabel';

    if (await canLaunchUrl(Uri.parse(mapUrl))) {
      await launchUrl(Uri.parse(mapUrl));
    } else {
      throw 'Could not launch $mapUrl';
    }
  }

  // Function to open Apple Maps (on iOS) or Google Maps (on Android)
  Future<void> openNativeMap(double lat, double lng, String locationLabel,
      BuildContext context) async
  {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      String url = 'https://maps.apple.com/?q=$lat,$lng&z=15&t=m';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback to Google Maps in browser
        final String fallbackUrl =
            'https://www.google.com/maps/search/?api=1&query=$lat,$lng';
        if (await canLaunchUrl(Uri.parse(fallbackUrl))) {
          await launchUrl(Uri.parse(fallbackUrl));
        } else {
          throw 'Could not launch maps';
        }
      }
    } else {
      // url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving&dir_action=navigate';
      openMap(lat, lng, locationLabel);
    }
  }

}

class Opportunity {
  final String id;
  final String propertyName;
  final String unitName;
  final String propertyLink;
  final String clientName;
  final String clientLink;
  final bool isFollowed;

  Opportunity({
    required this.id,
    required this.propertyName,
    required this.unitName,
    required this.propertyLink,
    required this.clientName,
    required this.clientLink,
    this.isFollowed = false,
  });

  Opportunity copyWith({
    String? id,
    String? propertyName,
    String? unitName,
    String? propertyLink,
    String? clientName,
    String? clientLink,
    bool? isFollowed,
  }) {
    return Opportunity(
      id: id ?? this.id,
      propertyName: propertyName ?? this.propertyName,
      unitName: unitName ?? this.unitName,
      propertyLink: propertyLink ?? this.propertyLink,
      clientName: clientName ?? this.clientName,
      clientLink: clientLink ?? this.clientLink,
      isFollowed: isFollowed ?? this.isFollowed,
    );
  }
}
