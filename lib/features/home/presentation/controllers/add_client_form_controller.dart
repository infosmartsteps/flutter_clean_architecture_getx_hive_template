import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import 'package:ksa_real_estates/features/home/domain/entities/lookups_entity.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/cities_parameters.dart';
import 'package:ksa_real_estates/features/home/domain/usecases/lookups_use_cases.dart';
import 'package:ksa_real_estates/features/home/presentation/widgets/snackbars/error_snackbar.dart';
import '../../../../core/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
part 'add_client_form_state.dart';

//lib/features/home/presentation/controllers/add_client_form_controller.dart
class AddClientFormController extends GetxController {
  final LookUpsUseCases lookUpsUseCases;

  AddClientFormController({required this.lookUpsUseCases});

  final AddClientFormState state =
      AddClientFormState(lookUpsUseCases: Get.find<LookUpsUseCases>());
  RxBool acquisition = false.obs;

  late List<FormFieldModel> fieldsToValidate = [
    state.clientNameField,
    state.responsiblePersonField,
    state.phoneNumberField,
    state.addressField,
    state.registrationNumberField,
    state.responsiblePersonPhoneField,
    state.emailField,
    state.clientLocationLatField,
    state.clientLocationLngField
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
    _loadDropdownData();
  }

  void _initializeFields() {
    state.clientNameField =
        createFieldModel('clientName', requiredFieldValidation);
    state.responsiblePersonField =
        createFieldModel('responsiblePerson', requiredFieldValidation);
    state.phoneNumberField =
        createFieldModel('phoneNumber', phoneNumberValidation);
    state.addressField = createFieldModel('address', requiredFieldValidation);
    state.registrationNumberField =
        createFieldModel('registrationNumber', requiredFieldValidation);
    state.responsiblePersonPhoneField =
        createFieldModel('responsiblePersonPhone', phoneNumberValidation);
    state.emailField = createFieldModel('email', emailValidation);
    state.clientLocationLatField = createFieldModel('clientLocationLat');
    state.clientLocationLngField = createFieldModel('clientLocationLng');
  }

  void _loadDropdownData() {
    state.getBusinessSectors();
    state.getCities();
    state.getInformationSources();
  }

  void openClientLocation() {
    Get.toNamed(AppRoutes.chooseLocationScreen,
            arguments: {"label": state.clientNameField.controller?.text})
        ?.then((value) {
      state.clientLocationLatField.controller?.text =
          value?.latitude.toString() ?? "";
      state.clientLocationLngField.controller?.text =
          value?.longitude.toString() ?? "";
    });
  }

  Future<void> saveForm() async {
    ClientEntity client = ClientEntity(
      clientName: state.clientNameField.controller!.text,
      responsiblePerson: state.responsiblePersonField.controller!.text,
      phoneNumber: state.phoneNumberField.controller!.text,
      address: state.addressField.controller!.text,
      registrationNumber:
          int.tryParse(state.registrationNumberField.controller!.text),
      responsiblePersonPhone:
          state.responsiblePersonPhoneField.controller!.text,
      email: state.emailField.controller!.text,
      clientLocationLat:
          double.tryParse(state.clientLocationLatField.controller!.text),
      clientLocationLng:
          double.tryParse(state.clientLocationLngField.controller!.text),
      businessSector: state.selectedBusinessSector.value,
      city: state.selectedCity.value,
      informationSource: state.selectedInformationSource.value,
      // dataUrl:
    );
    Get.back(
        closeOverlays: true,
        result: {"client": client, "acquisition": acquisition.value});
    Get.snackbar('Success'.tr, 'Client added successfully'.tr,
        snackPosition: SnackPosition.BOTTOM);
  }

  @override
  void dispose() {
    state.dispose();
    super.dispose();
  }
}
