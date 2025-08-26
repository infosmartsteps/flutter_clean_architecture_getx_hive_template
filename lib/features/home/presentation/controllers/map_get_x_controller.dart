import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/routes/app_routes.dart';
import '../../../../core/utils/responsive_size_helper.dart';

class MapGetXController extends GetxController {
  final bool isLive;

  MapGetXController({required this.isLive});

  final Rx<MapController> mapController = MapController().obs;
  Rx<LatLng> currentLocation = LatLng(0, 0).obs;
  RxBool locationPermissionGranted = false.obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxDouble zoom = 15.0.obs;
  RxBool isMapReady = false.obs;
  RxBool isShowFlag = false.obs;
  late Rx<Marker> locationMarker = Marker(
    width: 80.0,
    height: 80.0,
    point: currentLocation.value,
    child: const Icon(
      Icons.location_pin,
      color: Colors.red,
      size: 40.0,
    ),
  ).obs;
  List<Placemark> placeMarks = [];
  Placemark place = Placemark();

  Future<Placemark?> getAddressFromLatLng() async {
    try {
      placeMarks = await placemarkFromCoordinates(
          currentLocation.value.latitude, currentLocation.value.longitude);

      if (placeMarks.isNotEmpty) {
        place = placeMarks.first;
        return place;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> checkLocationPermission() async {
    try {
      final status = await Permission.location.status;

      if (status.isGranted) {
        getCurrentLocation();
      } else {
        final result = await Permission.location.request();

        if (result.isGranted) {
          getCurrentLocation();
        } else {
          locationPermissionGranted.value = false;
          isLoading.value = false;
          errorMessage.value = 'Location permission denied';
          update();
        }
      }
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Error checking permissions: $e';
      update();
    }
  }

  void toggleFlag() {
    isShowFlag.value = !isShowFlag.value;
    update();
  }

  void initialization() async {
    if(!isLive){
      final index = Get.arguments['index'];
      final isClient = Get.routing.current == AppRoutes.clientInformationScreen;
      final InterestedClientsController interestedClientsController =
      Get.find<InterestedClientsController>();
      final opportunities = interestedClientsController.opportunities[index];
      currentLocation.value = isClient
          ? opportunities.clientLocation
          : opportunities.propertyLocation;
      getAddressFromLatLng();
      isLoading.value = false;
    }
    if (isLive) await checkLocationPermission();
    locationMarker.value = Marker(
      alignment: Alignment.topCenter,
      point: currentLocation.value,
      width: responsiveWidth(
          !(isShowFlag.value && (Get.arguments != null && Get.arguments != ''))
              ? 40
              : 70),
      height: responsiveHeight(
          !(isShowFlag.value && (Get.arguments != null && Get.arguments != ''))
              ? 40
              : 67),
      child: InkWell(
        onTap: toggleFlag,
        child:
            isShowFlag.value && (Get.arguments != null && Get.arguments != '')
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          color: Colors.black,
                          child: Text(Get.arguments,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.whiteColor))),
                      Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: responsiveFont(30),
                      ),
                    ],
                  )
                : Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: responsiveFont(30),
                  ),
      ),
    );
  }

  @override
  void onInit() {
    initialization();
    super.onInit();
  }

  void setCurrentLocation(LatLng point) {
    currentLocation.value = LatLng(point.latitude, point.longitude);
    locationMarker.value = Marker(
      alignment: Alignment.topCenter,
      point: currentLocation.value,
      width: responsiveWidth(
          !(isShowFlag.value && (Get.arguments != null && Get.arguments != ''))
              ? 40
              : 70),
      height: responsiveHeight(
          !(isShowFlag.value && (Get.arguments != null && Get.arguments != ''))
              ? 40
              : 67),
      child: InkWell(
        onTap: toggleFlag,
        child:
            isShowFlag.value && (Get.arguments != null && Get.arguments != '')
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          color: Colors.black,
                          child: Text(Get.arguments,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(Get.context!)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppColors.whiteColor))),
                      Icon(
                        Icons.location_history_rounded,
                        color: Colors.red,
                        size: responsiveFont(30),
                      ),
                    ],
                  )
                : Icon(
                    Icons.location_history_rounded,
                    color: Colors.red,
                    size: responsiveFont(30),
                  ),
      ),
    );
    update();
  }

  Future<void> getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        isLoading.value = false;
        errorMessage.value = 'Location services are disabled';
        update();
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentLocation.value = LatLng(position.latitude, position.longitude);
      locationPermissionGranted.value = true;
      isLoading.value = false;
      // update();

      // Only move the map if it's ready
      if (isMapReady.value) {
        mapController.value
            .move(LatLng(position.latitude, position.longitude), zoom.value);
      }
      locationMarker.value = Marker(
        alignment: Alignment.topCenter,
        point: currentLocation.value,
        width: responsiveWidth(!(isShowFlag.value &&
                (Get.arguments != null && Get.arguments != ''))
            ? 40
            : 70),
        height: responsiveHeight(!(isShowFlag.value &&
                (Get.arguments != null && Get.arguments != ''))
            ? 40
            : 67),
        child: InkWell(
          onTap: toggleFlag,
          child:
              isShowFlag.value && (Get.arguments != null && Get.arguments != '')
                  ? Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            color: Colors.black,
                            child: Text(Get.arguments,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(Get.context!)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(color: AppColors.whiteColor))),
                        Icon(
                          Icons.location_history_rounded,
                          color: Colors.red,
                          size: responsiveFont(30),
                        ),
                      ],
                    )
                  : Icon(
                      Icons.location_history_rounded,
                      color: Colors.red,
                      size: responsiveFont(30),
                    ),
        ),
      );
      update();
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Error getting location: $e';
      update();
    }
    update();
  }

  Future<void> refreshLocation() async {
    isLoading.value = true;
    errorMessage.value = '';
    update();
    await getCurrentLocation();
  }

  void saveLocation() {
    Get.back(result: currentLocation.value);
  }

  @override
  void onClose() {
    mapController.value.dispose();
    currentLocation.value = LatLng(0, 0);
    locationPermissionGranted.value = false;
    isLoading.value = true;
    errorMessage.value = '';
    isMapReady.value = false;
    super.onClose();
  }

  @override
  void dispose() {
    mapController.value.dispose();
    currentLocation.value = LatLng(0, 0);
    locationPermissionGranted.value = false;
    isLoading.value = true;
    errorMessage.value = '';
    isMapReady.value = false;
    super.dispose();
  }
}
