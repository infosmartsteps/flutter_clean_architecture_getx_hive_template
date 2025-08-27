import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';
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

  final FormFocusManager focusManager = FormFocusManager();
  final AddClientFormState state =
      AddClientFormState(lookUpsUseCases: Get.find<LookUpsUseCases>());

  @override
  void onInit() {
    super.onInit();
    _initializeFields();
    _loadDropdownData();
  }

  void _initializeFields() {
    state.clientNameField =
        _createFieldModel('clientName', requiredFieldValidation);
    state.responsiblePersonField =
        _createFieldModel('responsiblePerson', requiredFieldValidation);
    state.phoneNumberField =
        _createFieldModel('phoneNumber', phoneNumberValidation);
    state.addressField = _createFieldModel('address', requiredFieldValidation);
    state.registrationNumberField =
        _createFieldModel('registrationNumber', requiredFieldValidation);
    state.responsiblePersonPhoneField =
        _createFieldModel('responsiblePersonPhone', phoneNumberValidation);
    state.emailField = _createFieldModel('email', emailValidation);
    state.clientLocationLatField = _createFieldModel('clientLocationLat');
    state.clientLocationLngField = _createFieldModel('clientLocationLng');
  }

  FormFieldModel _createFieldModel(String key,
      [String? Function(String?)? validation]) {
    return FormFieldModel(
        name: key,
        focusNode: focusManager.getFocusNode(key),
        key: focusManager.getFieldKey(key),
        controller: TextEditingController(),
        validator: validation);
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

  void scrollToField(String fieldName) {
    final context = state.formKey.currentContext;
    if (context != null) {
      final key = focusManager.getFieldKey(fieldName);
      Scrollable.ensureVisible(key.currentContext!,
          duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
      focusManager.requestFocus(fieldName);
    }
  }

  void validateAndScrollToFirstError() {
    final fieldsToValidate = [
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
    for (final field in fieldsToValidate) {
      final error = field.validator?.call(field.controller?.text);
      if (error != null) {
        scrollToField(field.name!);
        return;
      }
    }
    _validateDropdowns();
  }

  void _validateDropdowns() {
    if (state.selectedBusinessSector.value == null) {
      scrollToField('businessSector');
    } else if (state.selectedCity.value == null) {
      scrollToField('city');
    } else if (state.selectedInformationSource.value == null) {
      scrollToField('informationSource');
    }
  }

  Future<void> saveForm() async {
    if (!state.formKey.currentState!.validate()) {
      validateAndScrollToFirstError();
      return;
    } else {
      Get.back(closeOverlays: true); // This will close dialog AND screen
      Get.snackbar('Success'.tr, 'Client added successfully'.tr,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void dispose() {
    state.dispose();
    focusManager.dispose();
    super.dispose();
  }
}
