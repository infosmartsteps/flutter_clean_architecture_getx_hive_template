import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/filter_parameters.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/post_opportunity_parameters.dart';
import 'package:latlong2/latlong.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/utils/form_utils.dart';
import '../../domain/entities/client_entity.dart';
import '../../domain/entities/opportunity_entity.dart';
import '../../domain/entities/property_entity.dart';
import '../../domain/usecases/my_opportunities_use_case.dart';
import '../widgets/snackbars/error_snackbar.dart';

// lib/features/home/presentation/controllers/my_opportunities_controller.dart
class MyOpportunitiesController extends GetxController {
  final MyOpportunitiesUseCase myOpportunitiesUseCase;

  MyOpportunitiesController({required this.myOpportunitiesUseCase});

  final RxBool isLoading = true.obs;
  final Rx<DateTime> fromDate = DateTime(
    DateTime.now().year,
    DateTime.now().month - 1,
    DateTime.now().day,
  ).obs;

  final Rx<DateTime> toDate = DateTime.now().obs;
  final RxString clientName = ''.obs;
  final RxString propertyName = ''.obs;
  final RxString propertyNumber = ''.obs;

  final RxList<OpportunityEntity> opportunities = <OpportunityEntity>[].obs;

  // Form Key
  final formKey = GlobalKey<FormState>();

  final Rx<FormFieldModel> priceField = FormFieldModel().obs;
  final Rx<FormFieldModel> noteField = FormFieldModel().obs;

  @override
  void onInit() {
    super.onInit();
    initialize();
  }

  Future<void> initialize() async {
    priceField.value = createFieldModel('price', requiredFieldValidation);
    noteField.value = createFieldModel('notes', requiredFieldValidation);
    await getMyOpportunities();
  }

  Future<void> getMyOpportunities() async {
    try {
      isLoading.value = true;

      final filterParameters = FilterParameters(
        clientName: clientName.value,
        propertyName: propertyName.value,
        propertyNumber: propertyNumber.value,
        from: fromDate.value.toString(),
        to: toDate.value.toString(),
      );

      final result =
          await myOpportunitiesUseCase.getMyOpportunities(filterParameters);

      result.fold(
        (failure) => showErrorSnackBar('Failed to get opportunities', failure),
        (opportunitiesList) => opportunities.value = opportunitiesList,
      );
    } catch (e) {
      showErrorSnackBar('Unexpected error occurred', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void goToClientInformationScreen(ClientEntity client) {
    Get.toNamed(
      AppRoutes.clientInformationScreen,
      arguments: {
        'client': client,
        "label": client.clientName ?? '',
        'point': LatLng(
          client.clientLocationLat ?? 0,
          client.clientLocationLng ?? 0,
        ),
      },
    );
  }

  void goToPropertyInformationScreen(PropertyEntity property) {
    Get.toNamed(
      AppRoutes.propertyInformationScreen,
      arguments: {
        'property': property,
        "label": property.propertyName,
        'point': LatLng(
          property.propertyLocationLat ?? 0,
          property.propertyLocationLng ?? 0,
        ),
      },
    );
  }

  void cancelFilter() {
    Get.back();
  }

  void applyFilter(
    String clientName,
    String from,
    String to,
    String? propertyName,
    String? propertyNumber,
  ) {
    this.clientName.value = clientName;
    this.propertyName.value = propertyName ?? '';
    this.propertyNumber.value = propertyNumber ?? '';
    fromDate.value = DateTime.parse(from);
    toDate.value = DateTime.parse(to);

    Get.back();
    getMyOpportunities();
  }

  void clearControllers(bool didPop) {
    priceField.value.controller?.clear();
    noteField.value.controller?.clear();
  }

  void completeOpportunity(OpportunityEntity opportunity) async {
    try {
      isLoading.value = true;

      final postOpportunityParameters = PostOpportunityParameters(
        priceField.value.controller!.text,
        noteField.value.controller!.text,
      );

      final result = await myOpportunitiesUseCase
          .postCompleteOpportunity(postOpportunityParameters);

      result.fold(
        (failure) => showErrorSnackBar('Failed to get opportunities', failure),
        (opportunitiesList) => opportunities.value = opportunitiesList,
      );
    } catch (e) {
      showErrorSnackBar('Unexpected error occurred', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void abandonOpportunity(OpportunityEntity opportunity) async {
    try {
      isLoading.value = true;

      final postOpportunityParameters = PostOpportunityParameters(
        priceField.value.controller!.text,
        noteField.value.controller!.text,
      );

      final result = await myOpportunitiesUseCase
          .postCompleteOpportunity(postOpportunityParameters);

      result.fold(
        (failure) => showErrorSnackBar('Failed to get opportunities', failure),
        (opportunitiesList) => opportunities.value = opportunitiesList,
      );
    } catch (e) {
      showErrorSnackBar('Unexpected error occurred', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void cancelOpportunity(OpportunityEntity opportunity) async {
    try {
      isLoading.value = true;

      final postOpportunityParameters = PostOpportunityParameters(
        priceField.value.controller!.text,
        noteField.value.controller!.text,
      );

      final result = await myOpportunitiesUseCase
          .postCompleteOpportunity(postOpportunityParameters);

      result.fold(
        (failure) => showErrorSnackBar('Failed to get opportunities', failure),
        (opportunitiesList) => opportunities.value = opportunitiesList,
      );
    } catch (e) {
      showErrorSnackBar('Unexpected error occurred', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
