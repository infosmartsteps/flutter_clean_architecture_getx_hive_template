//lib/features/home/data/models/property_model.dart
class PropertyModel {
  final String? id;
  final String? propertyName;
  final String? unitName;
  final int? realEstateType; // true for sale, false for rent
  final double? maxPrice;
  final double? minPrice;
  final String? dataUrl;
  final double? propertyLocationLat;
  final double? propertyLocationLng;

  PropertyModel({
    this.id,
    this.propertyName,
    this.unitName,
    this.realEstateType,
    this.maxPrice,
    this.minPrice,
    this.dataUrl,
    this.propertyLocationLat,
    this.propertyLocationLng,
  });

  // Convert to Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'propertyName': propertyName,
      'unitName': unitName,
      'realEstateType': realEstateType,
      'maxPrice': maxPrice,
      'minPrice': minPrice,
      'dataUrl': dataUrl,
      "propertyLocationLat": propertyLocationLat,
      "propertyLocationLng": propertyLocationLng,
    }..removeWhere((key, value) => value == null || value == '');
  }

  // Create from Map
  factory PropertyModel.fromJson(Map<String, dynamic> map) {
    return PropertyModel(
      id: map['id'],
      propertyName: map['propertyName'],
      unitName: map['unitName'],
      realEstateType: map['realEstateType'],
      maxPrice: map['maxPrice'],
      minPrice: map['minPrice'],
      dataUrl: map['dataUrl'],
      propertyLocationLat: map["propertyLocationLat"],
      propertyLocationLng: map["propertyLocationLng"],
    );
  }

  static List<PropertyModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => PropertyModel.fromJson(item)).toList();
  }
}
