import 'package:latlong2/latlong.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  bool _locationPermissionGranted = false;
  bool _isLoading = true;
  String _errorMessage = '';
  bool _isMapReady = false; // Add this flag

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    try {
      final status = await Permission.location.status;

      if (status.isGranted) {
        _getCurrentLocation();
      } else {
        final result = await Permission.location.request();

        if (result.isGranted) {
          _getCurrentLocation();
        } else {
          setState(() {
            _locationPermissionGranted = false;
            _isLoading = false;
            _errorMessage = 'Location permission denied';
          });
        }
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error checking permissions: $e';
      });
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Location services are disabled';
        });
        return;
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _locationPermissionGranted = true;
        _isLoading = false;
      });

      // Only move the map if it's ready
      if (_isMapReady && mounted) {
        _mapController.move(_currentLocation!, 15.0);
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Error getting location: $e';
      });
    }
  }

  Future<void> _refreshLocation() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });
    await _getCurrentLocation();
  }

  Widget _buildMap() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_errorMessage, textAlign: TextAlign.center),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkLocationPermission,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentLocation ?? const LatLng(0, 0),
        initialZoom: _currentLocation != null ? 15.0 : 3.0,
        onTap: (tapPosition, point) {
          _currentLocation = LatLng(point.latitude, point.longitude);
          setState(() {});
        },
        onMapReady: () {
          // Set flag when map is ready
          setState(() {
            _isMapReady = true;
          });

          // Move to current location if we have it
          if (_currentLocation != null) {
            _mapController.move(_currentLocation!, 15.0);
          }
        },
      ),
      children: [
        // OpenStreetMap Tile Layer
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.flutter_map_example',
        ),

        // Location Marker Layer
        if (_locationPermissionGranted && _currentLocation != null)
          CurrentLocationLayer(
            alignPositionOnUpdate: AlignOnUpdate.always,
            alignDirectionOnUpdate: AlignOnUpdate.never,
          ),

        // Marker for current location (fallback)
        if (_currentLocation != null)
          MarkerLayer(
            markers: [
              Marker(
                point: _currentLocation!,
                width: 40,
                height: 40,
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterMap with Location'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _currentLocation != null && _isMapReady
                ? () => _mapController.move(_currentLocation!, 15.0)
                : null,
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshLocation,
          ),
        ],
      ),
      body: _buildMap(),
      floatingActionButton: _currentLocation != null && _isMapReady
          ? FloatingActionButton(
              onPressed: () => _mapController.move(_currentLocation!, 15.0),
              child: const Icon(Icons.my_location),
            )
          : null,
    );
  }
}
