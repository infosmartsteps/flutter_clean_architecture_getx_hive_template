import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../../../../../core/utils/responsive_size_helper.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  // Initial map position (San Francisco)
  final LatLng _initialPosition = const LatLng(31.986040, 35.879221);
  final double _initialZoom = 15.0;
  Placemark? _placemark;

  // Marker for the map
  final Marker _locationMarker = Marker(
    width: 80.0,
    height: 80.0,
    point: LatLng(31.986040, 35.879221),
    child: const Icon(
      Icons.location_pin,
      color: Colors.red,
      size: 40.0,
    ),
  );
  List<Placemark> placeMarks = [];
  Placemark place = Placemark();

  Future<Placemark?> getAddressFromLatLng(LatLng latLng) async {
    try {
      placeMarks =
      await placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placeMarks.isNotEmpty) {
        place = placeMarks.first;
        return place;
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  void initState() {
    getAddressFromLatLng(_initialPosition);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              keepAlive: false,
              initialCenter: _initialPosition,
              initialZoom: _initialZoom,
            ),
            children: [
              // OpenStreetMap tile layer
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c'],
                userAgentPackageName: 'com.example.flutter_map_example',
                tileProvider: CancellableNetworkTileProvider(),
              ),
              // Marker layer
              MarkerLayer(
                markers: [_locationMarker],
              ),
            ],
          ),
          Container(
            color: Colors.transparent,
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.defaultDialog(
              title: "Location Info",
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: responsiveHeight(10),
                children: [
                  Text('Country: ${place.country}'),
                  Text('City: ${place.locality}'),
                  Text('SubLocality: ${place.subLocality}'),
                  Text('Street: ${place.street}'),
                  if (place.postalCode != null && place.postalCode!.isNotEmpty)
                    Text('Postal Code: ${place.postalCode}'),
                  Text('latitude: ${_initialPosition.latitude}'),
                  Text('longitude: ${_initialPosition.longitude}'),
                ],
              ));
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.info, color: Colors.white),
      ),
    );
  }
}