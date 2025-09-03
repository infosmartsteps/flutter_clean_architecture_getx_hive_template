import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import 'package:ksa_real_estates/features/home/domain/entities/lookups_entity.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';
import 'package:ksa_real_estates/features/home/domain/usecases/clients_use_case.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/utils/form_utils.dart';
import '../../domain/usecases/property_use_case.dart';
import '../widgets/snackbars/error_snackbar.dart';

// lib/features/home/presentation/controllers/available_opportunities_controller.dart
class AvailableOpportunitiesController extends GetxController {
  final PropertyUseCase propertyUseCase;
  final ClientsUseCase clientsUseCase;
  final formKey = GlobalKey<FormState>().obs;
  final isLoading = false.obs;
  final properties = <PropertyEntity>[].obs;
  final clients = <ClientEntity>[].obs;
  final clientsLookups = <LookupsEntity>[].obs;
  final fieldModel = FormFieldModel().obs;
  final selectedClient = Rx<String?>(null);
  RxString filterValue = ''.obs;

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
          (failure) => showErrorSnackBar('Failed to get properties', failure),
          (propertiesList) => properties.value = propertiesList);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getClients() async {
    try {
      isLoading.value = true;
      final result = await clientsUseCase.getClients();
      result.fold(
        (failure) => showErrorSnackBar('Failed to get clients', failure),
        (clientsList) {
          clientsLookups.value = clientsList
              .where((client) => client.id != null && client.clientName != null)
              .map((client) =>
                  LookupsEntity(id: client.id!, value: client.clientName!))
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
    if (formKey.value.currentState!.validate()) {
      Get.back();
    }
  }

  Future<void> goToAddClient() async {
    final result = await Get.toNamed(AppRoutes.addClientForm);

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
