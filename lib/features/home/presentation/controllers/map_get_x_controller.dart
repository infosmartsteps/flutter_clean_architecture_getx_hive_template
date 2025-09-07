import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/functions/launch_url.dart';
import '../../../../core/utils/functions/share_plus.dart';
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
      color: AppColors.redColor,
      size: 40.0,
    ),
  ).obs;
  List<Placemark> placeMarks = [];
  Placemark place = Placemark();

  Rx<InteractionOptions> interactionOption = InteractionOptions().obs;

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

  void toggleFlag() {
    isShowFlag.value = !isShowFlag.value;
    setLocationMarker();
    update();
  }

  void initialization() async {
    if (!isLive) {
      currentLocation.value = Get.arguments['point'];
      getAddressFromLatLng();
      isLoading.value = false;
      zoom.value = 14.0;
      interactionOption.value = InteractionOptions(
        flags: InteractiveFlag.none, // Disable all interactive flags
        // Or selectively disable drag:
        // flags: InteractiveFlag.all & ~InteractiveFlag.drag,
      );
    }
    if (isLive) await checkLocationPermission();
    setLocationMarker();
  }

  void setLocationMarker() {
    final bool shouldShowFlag = isShowFlag.value &&
        Get.arguments != null &&
        Get.arguments != '' &&
        Get.arguments is Map<String, dynamic>;

    final double markerWidth = responsiveWidth(shouldShowFlag ? 90 : 40);
    final double markerHeight = responsiveHeight(shouldShowFlag ? 80 : 40);

    Widget markerChild;

    if (shouldShowFlag) {
      final String label = Get.arguments["label"] ?? '';
      markerChild = Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: AppColors.blackColor,
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(Get.context!).textTheme.bodySmall?.copyWith(
                  color: AppColors.whiteColor, fontSize: responsiveFont(8)),
            ),
          ),
          Icon(
            Icons.location_history_rounded,
            color: AppColors.redColor,
            size: responsiveFont(30),
          ),
        ],
      );
    } else {
      markerChild = Icon(
        Icons.location_history_rounded,
        color: AppColors.redColor,
        size: responsiveFont(30),
      );
    }

    locationMarker.value = Marker(
      alignment: Alignment.topCenter,
      point: currentLocation.value,
      width: markerWidth,
      height: markerHeight,
      child: InkWell(
        onTap: toggleFlag,
        child: markerChild,
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
    setLocationMarker();
    update();
  }

  void onMapReady() {
    isMapReady.value = true;
    update();
    initialization();
    update();
    mapController.value.move(currentLocation.value, zoom.value);
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

  Future<void> shareLocation() async {
    String mapUrl;
    if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      mapUrl =
          'https://maps.apple.com/?q=${currentLocation.value.latitude},${currentLocation.value.longitude}&z=15&t=m';
    } else {
      mapUrl =
          'https://www.google.com/maps/search/?api=1&query=${currentLocation.value.latitude},${currentLocation.value.longitude}&query_place_id=Googleplex';
    }
    await share(text: mapUrl);
  }

  Future<void> openMap() async {
    final String mapUrl =
        'https://www.google.com/maps/search/?api=1&query=${currentLocation.value.latitude},${currentLocation.value.longitude}&query_place_id=Googleplex';
    launchUrlHelper(mapUrl);
  }

  Future<void> openNativeMap() async {
    if (Theme.of(Get.context!).platform == TargetPlatform.iOS) {
      String url =
          'https://maps.apple.com/?q=${currentLocation.value.latitude},${currentLocation.value.longitude}&z=15&t=m';
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      } else {
        // Fallback to Google Maps in browser
        final String fallbackUrl =
            'https://www.google.com/maps/search/?api=1&query=${currentLocation.value.latitude},${currentLocation.value.longitude}';
        launchUrlHelper(fallbackUrl);
      }
    } else {
      // url = 'https://www.google.com/maps/dir/?api=1&destination=$lat,$lng&travelmode=driving&dir_action=navigate';
      openMap();
    }
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

  Future<void> checkLocationPermission() async {
    isLoading.value = true;
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission = await Geolocator.checkPermission();
    if (serviceEnabled) {
      await getCurrentLocation();
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        await Geolocator.openAppSettings();
        await getCurrentLocation();
      } else {
        await getCurrentLocation();
      }
    }

    if (permission == LocationPermission.deniedForever) {
      await Geolocator.openAppSettings();
      errorMessage.value = 'Location services are disabled';
      throw "language lbl Location Permission Denied Permanently, please enable it from setting";
    }

    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((value) async {
      await getCurrentLocation();
    }).catchError((e) async {
      await Geolocator.getLastKnownPosition().then((value) async {
        if (value != null) {
          await getCurrentLocation();
          // return value;
        } else {
          // throw "lbl Enable Location";
        }
      }).catchError((e) {
        Get.log(e.toString());
      });
    });

    errorMessage.value = '';
    isLoading.value = false;
    update();
  }

  Future<void> getCurrentLocation() async {
    try {
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
      setLocationMarker();
      update();
    } catch (e) {
      isLoading.value = false;
      errorMessage.value = 'Error getting location: $e';
      update();
    }
    update();
  }
}
