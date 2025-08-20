import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';

class MapGetXController extends GetxController {
  final Rx<MapController> mapController = MapController().obs;
  Rx<LatLng> currentLocation = LatLng(0, 0).obs;
  RxBool locationPermissionGranted = false.obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;
  RxDouble zoom = 15.0.obs;

  RxBool isMapReady = false.obs;
  RxBool isShowFlag = false.obs;

  // Rx<LatLng> savedLocation = LatLng(0, 0).obs;
  toggleFlag() {
    isShowFlag.value = !isShowFlag.value;
    update();
  }

  @override
  void onInit() {
    checkLocationPermission();
    super.onInit();
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

  saveLocation() {
    Get.back(result: currentLocation.value);
  }

  @override
  void onClose() {
    mapController.value.dispose();
    currentLocation.value = LatLng(0, 0);
    // savedLocation.value = LatLng(0, 0);
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
    // savedLocation.value = LatLng(0, 0);
    locationPermissionGranted.value = false;
    isLoading.value = true;
    errorMessage.value = '';
    isMapReady.value = false;
    super.dispose();
  }
}
