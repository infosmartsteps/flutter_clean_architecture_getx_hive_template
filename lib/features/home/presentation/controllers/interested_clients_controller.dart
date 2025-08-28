import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:ksa_real_estates/core/utils/functions/launch_url.dart';
import 'package:ksa_real_estates/core/utils/functions/share_plus.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';
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

  void goToClientInformationScreen(ClientEntity client) async {
    Get.toNamed(AppRoutes.clientInformationScreen, arguments: {
      'client': client,
      "label": client.clientName ?? '',
      'point':
          LatLng(client.clientLocationLat ?? 0, client.clientLocationLng ?? 0)
    });
  }

  void goToPropertyInformationScreen(PropertyEntity property) async {
    Get.toNamed(AppRoutes.propertyInformationScreen, arguments: {
      'property': property,
      "label": property.propertyName,
      'point': LatLng(
          property.propertyLocationLat ?? 0, property.propertyLocationLng ?? 0)
    });
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
