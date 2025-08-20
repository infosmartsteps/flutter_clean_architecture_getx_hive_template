import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/core/constants/routes/app_routes.dart';

import '../../../../core/utils/functions/validation.dart';

class AddClientFormController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  // Field focus nodes
  final clientNameFocus = FocusNode();
  final responsiblePersonFocus = FocusNode();
  final phoneNumberFocus = FocusNode();
  final businessSectorFocus = FocusNode();
  final addressFocus = FocusNode();
  final registrationNumberFocus = FocusNode();
  final responsiblePersonPhoneFocus = FocusNode();
  final cityFocus = FocusNode();
  final informationSourceFocus = FocusNode();
  final emailFocus = FocusNode();

  // controllers
  final clientNameController = TextEditingController();
  final responsiblePersonController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final addressController = TextEditingController();
  final registrationNumberController = TextEditingController();
  final responsiblePersonPhoneController = TextEditingController();
  final emailController = TextEditingController();
  final clientLocationLatController = TextEditingController();
  final clientLocationLngController = TextEditingController();

  String? selectedBusinessSector;
  String? selectedCity;
  String? selectedInformationSource;

  // Dropdown options
  final RxList<String> businessSectors = <String>[].obs;

  final RxList<String> cities = <String>[].obs;

  final RxList<String> informationSources = <String>[].obs;

  void getBusinessSectors() async {
    await Future.delayed(Duration(seconds: 2));
    businessSectors.value = [
      'تجزئة',
      'تصنيع',
      'رعاية صحية',
      'تعليم',
      'تكنولوجيا',
      'تمويل',
      'ضيافة',
      'بناء',
      'نقل',
      'أخرى'
    ];
  }

  Future<void> getCities() async {
    await Future.delayed(Duration(seconds: 2));
    cities.value = [
      'الرياض',
      'جدة',
      'مكة',
      'المدينة المنورة',
      'الدمام',
      'الخبر',
      'الطائف',
      'بريدة',
      'تبوك',
      'أبها'
    ];
    update();
  }

  void getInformationSources() async {
    await Future.delayed(Duration(seconds: 2));
    informationSources.value = [
      'الإنترنت',
      'إعلان',
      'معرض',
      'توصية',
      'وسائل التواصل الاجتماعي',
      'أخرى'
    ];
  }

  void selectCity(String? value) {
    selectedCity = value;
  }

  void selectInformationSource(String? value) {
    selectedInformationSource = value;
  }

  void selectBusinessSector(String? value) {
    selectedBusinessSector = value;
  }

  // Helper function to scroll to and focus on a field
  void scrollToField(FocusNode focusNode, [double offset = 0]) async {
    scrollController.animateTo(
      offset,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    if (focusNode.hasFocus) {
      Get.focusScope?.unfocus();
      await Future.delayed(const Duration(milliseconds: 300));
    }
    focusNode.requestFocus();
  }

  openClientLocation() {
    Get.toNamed(AppRoutes.mapScreen, arguments: clientNameController.text)
        ?.then((value) {
      clientLocationLatController.text =
          value != null ? value.latitude.toString() : "";
      clientLocationLngController.text =
          value != null ? value.longitude.toString() : "";
    });
  }

  void saveForm() {
    if (!formKey.currentState!.validate()) {
      // Find the first field with an error and scroll to it
      if (clientNameController.text.isEmpty) {
        scrollToField(clientNameFocus);
      } else if (requiredFieldValidation(responsiblePersonController.text) !=
          null) {
        scrollToField(responsiblePersonFocus);
      } else if (phoneNumberValidation(phoneNumberController.text) != null) {
        scrollToField(phoneNumberFocus);
      } else if (selectedBusinessSector == null) {
        scrollToField(businessSectorFocus, 200);
      } else if (selectedCity == null) {
        scrollToField(cityFocus, 300);
      } else if (requiredFieldValidation(addressController.text) != null) {
        scrollToField(addressFocus);
      } else if (requiredFieldValidation(registrationNumberController.text) !=
          null) {
        scrollToField(registrationNumberFocus);
      } else if (requiredFieldValidation(
              responsiblePersonPhoneController.text) !=
          null) {
        scrollToField(responsiblePersonPhoneFocus);
      } else if (selectedInformationSource == null) {
        scrollToField(informationSourceFocus, 400);
      } else if (emailValidation(emailController.text) != null) {
        scrollToField(emailFocus);
      }
      return;
    }
    // If form is valid, proceed with saving
    Get.back();
    Get.snackbar(
      'Success'.tr,
      'Client added successfully'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  @override
  void onInit() async{
    getBusinessSectors();
    await getCities();
    getInformationSources();
    super.onInit();
  }

  @override
  void dispose() {
    scrollController.dispose();
    clientNameFocus.dispose();
    phoneNumberFocus.dispose();
    businessSectorFocus.dispose();
    cityFocus.dispose();
    informationSourceFocus.dispose();
    emailFocus.dispose();
    clientNameController.dispose();
    responsiblePersonController.dispose();
    phoneNumberController.dispose();
    addressController.dispose();
    registrationNumberController.dispose();
    responsiblePersonPhoneController.dispose();
    emailController.dispose();
    clientLocationLatController.dispose();
    clientLocationLngController.dispose();
    super.dispose();
  }
}
