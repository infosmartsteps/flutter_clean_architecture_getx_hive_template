part of 'add_client_form_controller.dart';

class AddClientFormState {
  final LookUpsUseCases lookUpsUseCases;

  AddClientFormState({required this.lookUpsUseCases});

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
  final RxList<LookupsEntity> businessSectors = <LookupsEntity>[].obs;
  final RxList<LookupsEntity> cities = <LookupsEntity>[].obs;
  final RxList<LookupsEntity> informationSources = <LookupsEntity>[].obs;

  // Loading states
  final isLoadingBusinessSectors = false.obs;
  final isLoadingCities = false.obs;
  final isLoadingInformationSources = false.obs;

  Future<void> getBusinessSectors() async {
    try {
      isLoadingBusinessSectors.value = true;
      final params = CitiesParameters(country: "saudi Arabia");
      final result = await lookUpsUseCases.getBusinessSectors();
      result.fold(
          (l) => Get.snackbar(
                'Filed In get Business Sectors',
                l,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Get.theme.colorScheme.error,
                colorText: Colors.white,
              ),
          (r) => businessSectors.value = r);
      isLoadingBusinessSectors.value = false;
    } finally {
      isLoadingBusinessSectors.value = false;
    }
  }

  Future<void> getCities() async {
    try {
      isLoadingCities.value = true;
      final params = CitiesParameters(country: "saudi Arabia");
      final result = await lookUpsUseCases.getCountries(params);
      result.fold(
          (l) => Get.snackbar(
                'Filed In Get Cities',
                l,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Get.theme.colorScheme.error,
                colorText: Colors.white,
              ),
          (r) => cities.value = r);
      isLoadingCities.value = false;
    } finally {
      isLoadingCities.value = false;
    }
  }

  Future<void> getInformationSources() async {
    try {
      isLoadingInformationSources.value = true;
      final params = CitiesParameters(country: "saudi Arabia");
      final result = await lookUpsUseCases.getInformationSources();
      result.fold(
          (l) => Get.snackbar(
                'Filed In get Information Sources',
                l,
                snackPosition: SnackPosition.BOTTOM,
                backgroundColor: Get.theme.colorScheme.error,
                colorText: Colors.white,
              ),
          (r) => informationSources.value = r);
      isLoadingInformationSources.value = false;
    } finally {
      isLoadingInformationSources.value = false;
    }
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
