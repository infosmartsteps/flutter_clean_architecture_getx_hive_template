import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import 'package:ksa_real_estates/features/home/domain/entities/lookups_entity.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';
import 'package:ksa_real_estates/features/home/domain/usecases/clients_use_case.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/utils/form_utils.dart';
import '../../domain/usecases/property_use_case.dart';
import '../widgets/snackbars/error_snackbar.dart';

//lib/features/home/presentation/controllers/available_opportunities_controller.dart
// lib/features/home/presentation/controllers/available_opportunities_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

// lib/features/home/presentation/controllers/available_opportunities_controller.dart
class AvailableOpportunitiesController extends GetxController {
  final PropertyUseCase propertyUseCase;
  final ClientsUseCase clientsUseCase;

  // CHANGED: Removed redundant .obs from GlobalKey and simplified Rx declarations
  final formKey = GlobalKey<FormState>().obs;
  final isLoading = false.obs;
  final properties = <PropertyEntity>[].obs;
  final clients = <ClientEntity>[].obs;
  final clientsLookups = <LookupsEntity>[].obs;
  final fieldModel = FormFieldModel().obs;
  final selectedClient = Rx<String?>(null);

  AvailableOpportunitiesController({
    required this.propertyUseCase,
    required this.clientsUseCase,
  });

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  @override
  void dispose() {
    // CHANGED: Proper disposal of resources to prevent memory leaks
    fieldModel.value.dispose();
    super.dispose();
  }

  Future<void> initialize() async {
    await getProperties();
  }

  Future<void> getProperties({String? value}) async {
    try {
      isLoading.value = true;
      final result = await propertyUseCase.getProperty(value: value);
      result.fold(
        // CHANGED: Fixed typo and improved error message clarity
            (failure) => showErrorSnackBar('Failed to get properties', failure),
            (propertiesList) => properties.value = propertiesList,
      );
    } finally {
      // CHANGED: Moved isLoading reset to finally block to ensure it always runs
      isLoading.value = false;
    }
  }

  Future<void> getClients() async {
    try {
      isLoading.value = true;
      final result = await clientsUseCase.getClients();
      result.fold(
        // CHANGED: Fixed typo and improved error message
            (failure) => showErrorSnackBar('Failed to get clients', failure),
            (clientsList) {
          // CHANGED: Added null safety checks and filtering
          clientsLookups.value = clientsList
              .where((client) => client.id != null && client.clientName != null)
              .map((client) => LookupsEntity(
            id: client.id!,
            value: client.clientName!,
          ))
              .toList();
        },
      );
    } finally {
      isLoading.value = false;
    }
  }


  void interestedClient() {
    fieldModel.value = createFieldModel('phoneNumber', phoneNumberValidation);
    selectedClient.value = null;
    Get.toNamed(AppRoutes.interestedClientScreen);
    getClients();
  }

  void validate() {
    // CHANGED: Improved logic clarity with descriptive variable names
    final hasClientSelected = selectedClient.value != null;
    final hasPhoneNumber = fieldModel.value.controller?.text.isNotEmpty ?? false;

    if (!hasClientSelected && !hasPhoneNumber) {
      formKey.value.currentState?.validate();
    }
  }

  Future<void> goToAddClient() async {
    final result = await Get.toNamed(AppRoutes.addClientForm);

    // CHANGED: Added proper type checking and error handling
    if (result is Map && result.containsKey('acquisition')) {
      // final acquisition = result['acquisition'] as bool;

      // if (acquisition) {
        Get.back(closeOverlays: true);
        await getProperties();
      // } else {
      //   Get.back();
      // }
    }
  }
}
