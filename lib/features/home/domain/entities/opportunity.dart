import 'package:latlong2/latlong.dart';

class Opportunity {
  final String id;
  final String propertyName;
  final String unitName;
  final String propertyLink;
  final String clientName;
  final String clientLink;
  final bool isFollowed;
  final LatLng clientLocation;
  final LatLng propertyLocation;

  Opportunity({
    required this.clientLocation,
    required this.propertyLocation,
    required this.id,
    required this.propertyName,
    required this.unitName,
    required this.propertyLink,
    required this.clientName,
    required this.clientLink,
    this.isFollowed = false,
  });

  Opportunity copyWith({
    String? id,
    String? propertyName,
    String? unitName,
    String? propertyLink,
    String? clientName,
    String? clientLink,
    bool? isFollowed,
    LatLng? clientLocation,
    LatLng? propertyLocation,
  }) {
    return Opportunity(
        id: id ?? this.id,
        propertyName: propertyName ?? this.propertyName,
        unitName: unitName ?? this.unitName,
        propertyLink: propertyLink ?? this.propertyLink,
        clientName: clientName ?? this.clientName,
        clientLink: clientLink ?? this.clientLink,
        isFollowed: isFollowed ?? this.isFollowed,
        clientLocation: clientLocation ?? this.clientLocation,
        propertyLocation: propertyLocation ?? this.propertyLocation);
  }
}
