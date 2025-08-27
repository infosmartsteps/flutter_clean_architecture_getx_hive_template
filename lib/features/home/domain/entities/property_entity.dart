// Property Model
import '../../data/models/property_model.dart';

class PropertyEntity {
  final String? id;
  final String? propertyName;
  final String? unitName;
  final int? realEstateType; // true for sale, false for rent
  final double? maxPrice;
  final double? minPrice;
  final String? dataUrl;
  final double? propertyLocationLat;
  final double? propertyLocationLng;

  PropertyEntity({
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

  factory PropertyEntity.fromResponse(PropertyModel response) => PropertyEntity(
        id: response.id,
        propertyName: response.propertyName,
        unitName: response.unitName,
        realEstateType: response.realEstateType,
        maxPrice: response.maxPrice,
        minPrice: response.minPrice,
        dataUrl: response.dataUrl,
        propertyLocationLat: response.propertyLocationLat,
        propertyLocationLng: response.propertyLocationLng,
      );

  static List<PropertyEntity> fromModelList(List<PropertyModel> modelList) {
    return modelList
        .map((model) => PropertyEntity.fromResponse(model))
        .toList();
  }
}
