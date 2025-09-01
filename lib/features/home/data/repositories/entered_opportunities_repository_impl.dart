import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';
import '../../../../core/network/handle_dio_error.dart';
import '../../../../core/network/models/response_model.dart';
import '../../domain/parameters/filter_parameters.dart';
import '../../domain/repositories/i_entered_opportunities_repository.dart';
import '../datasources/entered_opportunities/i_entered_opportunities_data_source.dart';
import '../models/property_model.dart';

class EnteredOpportunitiesRepositoryImpl
    extends IEnteredOpportunitiesRepository {
  final IEnteredOpportunitiesDataSource iEnteredOpportunitiesDataSource;

  EnteredOpportunitiesRepositoryImpl(
      {required this.iEnteredOpportunitiesDataSource});

  @override
  Future<Either<String, List<PropertyEntity>>> getEnteredOpportunities(
      FilterParameters filterParameters) async {
    try {
      final response = await iEnteredOpportunitiesDataSource
          .getEnteredOpportunities(filterParameters);
      if (!response.success) {
        return Left(response.message ?? "getCities failed");
      }
      final List<Map<String, dynamic>> properties = [
        {
          "id": "prop_001",
          "propertyName": "Skyline Towers",
          "unitName": "Unit 15B",
          "realEstateType": 1,
          "maxPrice": 750000.0,
          "minPrice": 500000.0,
          "dataUrl": "https://example.com/properties/skyline-towers",
          "propertyLocationLat": 40.7589,
          "propertyLocationLng": -73.9851
        },
        {
          "id": "prop_002",
          "propertyName": "Ocean View Apartments",
          "unitName": "Apartment 304",
          "realEstateType": 0,
          "maxPrice": 3500.0,
          "minPrice": 2800.0,
          "dataUrl": "https://example.com/properties/ocean-view",
          "propertyLocationLat": 34.0089,
          "propertyLocationLng": -118.4963
        },
        {
          "id": "prop_003",
          "propertyName": "Downtown Loft",
          "unitName": "Loft #5",
          "realEstateType": 1,
          "maxPrice": 425000.0,
          "minPrice": 395000.0,
          "propertyLocationLat": 41.8837,
          "propertyLocationLng": -87.6324
        },
        {
          "id": "prop_004",
          "propertyName": "Garden Villas",
          "unitName": "Villa 12",
          "realEstateType": 0,
          "maxPrice": 5200.0,
          "minPrice": 4500.0,
          "dataUrl": "https://example.com/properties/garden-villas",
          "propertyLocationLat": 37.3382,
          "propertyLocationLng": -121.8863
        },
        {
          "id": "prop_005",
          "propertyName": "Mountain Retreat",
          "unitName": "Cabin A",
          "realEstateType": 1,
          "maxPrice": 1200000.0,
          "minPrice": 950000.0,
          "dataUrl": "https://example.com/properties/mountain-retreat",
          "propertyLocationLat": 39.7392,
          "propertyLocationLng": -104.9903
        },
        {
          "id": "prop_006",
          "propertyName": "Urban Studio",
          "unitName": "Studio 8",
          "realEstateType": 0,
          "maxPrice": 1800.0,
          "minPrice": 1500.0,
          "propertyLocationLat": 47.6062,
          "propertyLocationLng": -122.3321
        },
        {
          "id": "prop_007",
          "propertyName": "Luxury Penthouse",
          "unitName": "Penthouse A",
          "realEstateType": 1,
          "maxPrice": 2500000.0,
          "minPrice": 2200000.0,
          "dataUrl": "https://example.com/properties/luxury-penthouse",
          "propertyLocationLat": 25.7617,
          "propertyLocationLng": -80.1918
        }
      ];
      final List<PropertyModel> models = PropertyModel.fromJsonList(properties);
      final List<PropertyEntity> entities =
          PropertyEntity.fromModelList(models);
      return Right(entities);
    } on DioException catch (e) {
      final apiResponse = handleDioError(e);
      return Left(apiResponse.message ?? "Network error");
    } on ApiResponse catch (e) {
      return Left(e.message ?? "API error");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}
