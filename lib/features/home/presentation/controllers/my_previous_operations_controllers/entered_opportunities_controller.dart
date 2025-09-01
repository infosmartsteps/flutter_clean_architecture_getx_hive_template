import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/filter_parameters.dart';
import '../../../domain/entities/property_entity.dart';
import '../../../domain/usecases/entered_opportunities_use_case.dart';
import '../../../domain/usecases/property_use_case.dart';
import '../../widgets/snackbars/error_snackbar.dart';

class EnteredOpportunitiesController extends GetxController {
  final EnteredOpportunitiesUseCase enteredOpportunitiesUseCase;

  EnteredOpportunitiesController({required this.enteredOpportunitiesUseCase});

  Rx<DateTime> from = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .obs;
  Rx<DateTime> to = DateTime.now().obs;
  RxString clientName = ''.obs;

  RxBool isLoading = true.obs;
  RxList<PropertyEntity> properties = <PropertyEntity>[].obs;

  Future<void> getEnteredOpportunities() async {
    try {
      isLoading.value = true;
      FilterParameters filterParameters = FilterParameters(
        clientName: clientName.value,
        from: from.toString(),
        to: to.toString(),
      );
      final result =
          await enteredOpportunitiesUseCase.getEnteredOpportunities(filterParameters);
      result.fold(
        (failure) => showErrorSnackBar('Failed to get properties', failure),
        (propertiesList) => properties.value = propertiesList,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initialize() async {
    await getEnteredOpportunities();
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  void cancel() {
    Get.back();
  }

  void apply(String clientName, String from, String to) async {
    this.clientName.value = clientName;
    this.from.value = DateTime.parse(from);
    this.to.value = DateTime.parse(to);

    Get.back();
    await getEnteredOpportunities();
  }
}
