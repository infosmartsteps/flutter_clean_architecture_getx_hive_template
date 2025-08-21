part of 'add_client_form_controller.dart';

class AddClientFormState {
  final formKey = GlobalKey<FormState>();
  final scrollController = ScrollController();

  // Field models
  late FormFieldModel clientNameField;
  late FormFieldModel responsiblePersonField;
  late FormFieldModel phoneNumberField;
  late FormFieldModel addressField;
  late FormFieldModel registrationNumberField;
  late FormFieldModel responsiblePersonPhoneField;
  late FormFieldModel emailField;
  late FormFieldModel clientLocationLatField;
  late FormFieldModel clientLocationLngField;

  // Dropdown values
  final selectedBusinessSector = Rx<String?>(null);
  final selectedCity = Rx<String?>(null);
  final selectedInformationSource = Rx<String?>(null);

  // Dropdown options
  final businessSectors = <String>[].obs;
  final cities = <String>[].obs;
  final informationSources = <String>[].obs;

  // Loading states
  final isLoadingBusinessSectors = false.obs;
  final isLoadingCities = false.obs;
  final isLoadingInformationSources = false.obs;

  Future<void> getBusinessSectors() async {
    isLoadingBusinessSectors.value = true;
    await Future.delayed(const Duration(seconds: 2));
    businessSectors.value = [
      'تجزئة', 'تصنيع', 'رعاية صحية', 'تعليم', 'تكنولوجيا',
      'تمويل', 'ضيافة', 'بناء', 'نقل', 'أخرى'
    ];
    isLoadingBusinessSectors.value = false;
  }

  Future<void> getCities() async {
    isLoadingCities.value = true;
    await Future.delayed(const Duration(seconds: 2));
    cities.value = [
      'الرياض', 'جدة', 'مكة', 'المدينة المنورة', 'الدمام',
      'الخبر', 'الطائف', 'بريدة', 'تبوك', 'أبها'
    ];
    isLoadingCities.value = false;
  }

  Future<void> getInformationSources() async {
    isLoadingInformationSources.value = true;
    await Future.delayed(const Duration(seconds: 2));
    informationSources.value = [
      'الإنترنت', 'إعلان', 'معرض', 'توصية',
      'وسائل التواصل الاجتماعي', 'أخرى'
    ];
    isLoadingInformationSources.value = false;
  }

  void dispose() {
    scrollController.dispose();

    clientNameField.dispose();
    responsiblePersonField.dispose();
    phoneNumberField.dispose();
    addressField.dispose();
    registrationNumberField.dispose();
    responsiblePersonPhoneField.dispose();
    emailField.dispose();
    clientLocationLatField.dispose();
    clientLocationLngField.dispose();
  }
}