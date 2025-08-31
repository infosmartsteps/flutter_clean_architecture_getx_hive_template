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
class AvailableOpportunitiesController extends GetxController {
  final PropertyUseCase propertyUseCase;
  final ClientsUseCase clientsUseCase;

  AvailableOpportunitiesController({
    required this.propertyUseCase,
    required this.clientsUseCase,
  });

  final FormFocusManager focusManager = FormFocusManager();
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;
  RxBool isLoading = false.obs;
  RxList<PropertyEntity> properties = <PropertyEntity>[].obs;
  RxList<ClientEntity> clients = <ClientEntity>[].obs;
  RxList<LookupsEntity> clientsLookups = <LookupsEntity>[].obs;
  Rx<FormFieldModel> fieldModel = FormFieldModel().obs;
  final selectedClient = Rx<String?>(null);

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  void initialize() async {
    await getProperties();
  }

  Future<void> getProperties() async {
    try {
      isLoading.value = true;
      final result = await propertyUseCase.getProperty();
      result.fold((l) => showErrorSnackBar('Filed In get Properties', l),
          (r) => properties.value = r);
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getClients() async {
    try {
      isLoading.value = true;
      final result = await clientsUseCase.getClients();
      result.fold(
          (l) => showErrorSnackBar('Filed In get Clients', l),
          (r) => clientsLookups.value = r
              .map((e) => LookupsEntity(id: e.id!, value: e.clientName!))
              .toList());
      isLoading.value = false;
    } finally {
      isLoading.value = false;
    }
  }

  void goToPropertyInformationScreen(PropertyEntity property) async {
    Get.toNamed(AppRoutes.propertyInformationScreen, arguments: {
      'property': property,
      "label": property.propertyName,
      'point': LatLng(
          property.propertyLocationLat ?? 0, property.propertyLocationLng ?? 0)
    });
  }

  interestedClient() {
    fieldModel.value = createFieldModel("phoneNumber", phoneNumberValidation);
    selectedClient.value = null;
    Get.toNamed(AppRoutes.interestedClientScreen);
    getClients();
  }

  validate() {
    if (selectedClient.value == null &&
        fieldModel.value.controller!.value.text.isEmpty) {
      formKey.value.currentState!.validate();
    }
  }

  void goToAddClient() async {
    final result = await Get.toNamed(AppRoutes.addClientForm);
    print(result["client"]);
    print(result["acquisition"]);
    final acquisition = result["acquisition"];
    if (acquisition) {
      Get.back(closeOverlays: true);
      getProperties();
    } else {
      Get.back();
    }
  }

  @override
  void dispose() {
    fieldModel.value.controller!.dispose();
    selectedClient.value = null;
    super.dispose();
  }
}
