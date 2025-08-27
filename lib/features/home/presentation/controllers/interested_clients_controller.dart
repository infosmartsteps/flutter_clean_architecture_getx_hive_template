import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:ksa_real_estates/core/utils/functions/launch_url.dart';
import 'package:ksa_real_estates/core/utils/functions/share_plus.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/opportunity_entity.dart';
import '../../domain/usecases/opportunities_use_case.dart';
import '../widgets/snackbars/error_snackbar.dart';

//lib/features/home/presentation/controllers/interested_clients_controller.dart
class InterestedClientsController extends GetxController {
  final OpportunitiesUseCase opportunitiesUseCase;

  InterestedClientsController({required this.opportunitiesUseCase});

  final RxList<OpportunityEntity> opportunities = <OpportunityEntity>[].obs;
  final RxBool isLoading = true.obs;

  Future<void> getOpportunities() async {
    try {
      isLoading.value = true;
      final result = await opportunitiesUseCase.getOpportunities();
      result.fold((l) => showErrorSnackBar('Filed In get Opportunities', l),
          (r) => opportunities.value = r);
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
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

  void goToInformationScreen(String page, int index, String label) async {
    Get.toNamed(page, arguments: {'index': index, "label": label});
  }

  Future<void> shareLocation() async {
    String mapUrl;
    if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      mapUrl =
          'https://maps.apple.com/?q=${getPoint().latitude},${getPoint().longitude}&z=15&t=m';
    } else {
      mapUrl =
          'https://www.google.com/maps/search/?api=1&query=${getPoint().latitude},${getPoint().longitude}&query_place_id=Googleplex';
    }
    await share(text: mapUrl);
  }

  LatLng getPoint() {
    LatLng point = LatLng(0, 0);
    if (Get.routing.current == AppRoutes.propertyInformationScreen) {
      point = opportunities[Get.arguments['index']].propertyLocation;
    } else if (Get.routing.current == AppRoutes.clientInformationScreen) {
      point = opportunities[Get.arguments['index']].clientLocation;
    }
    return point;
  }

  Future<void> openMap() async {
    final String mapUrl =
        'https://www.google.com/maps/search/?api=1&query=${getPoint().latitude},${getPoint().longitude}&query_place_id=Googleplex';
    launchUrlHelper(mapUrl);
  }

  Future<void> openNativeMap() async {
    if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      String url =
          'https://maps.apple.com/?q=${getPoint().latitude},${getPoint().longitude}&z=15&t=m';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback to Google Maps in browser
        final String fallbackUrl =
            'https://www.google.com/maps/search/?api=1&query=${getPoint().latitude},${getPoint().longitude}';
        launchUrlHelper(fallbackUrl);
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
    launchUrlHelper('', launchUri: launchUri);
  }

  void launchEmail({required String mailtoUrl}) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: mailtoUrl,
    );
    launchUrlHelper('', launchUri: launchUri);
  }
}
