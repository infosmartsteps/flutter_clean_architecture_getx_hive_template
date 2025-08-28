import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../domain/usecases/property_use_case.dart';
import '../widgets/snackbars/error_snackbar.dart';

class AvailableOpportunitiesController extends GetxController {
  final PropertyUseCase propertyUseCase;

  AvailableOpportunitiesController({required this.propertyUseCase});

  RxBool isLoading = false.obs;
  RxList<PropertyEntity> properties = <PropertyEntity>[].obs;

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

  void goToPropertyInformationScreen(PropertyEntity property) async {
    Get.toNamed(AppRoutes.propertyInformationScreen, arguments: {
      'property': property,
      "label": property.propertyName,
      'point': LatLng(
          property.propertyLocationLat ?? 0, property.propertyLocationLng ?? 0)
    });
  }

  interestedClient() {
    Get.toNamed(AppRoutes.chooseClientScreen);
  }
}
