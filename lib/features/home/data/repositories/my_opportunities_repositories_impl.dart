import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ksa_real_estates/features/home/data/datasources/my_opportunities/i_my_opportunities_data_source.dart';
import 'package:ksa_real_estates/features/home/domain/entities/opportunity_entity.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/post_opportunity_parameters.dart';

import '../../../../core/network/handle_dio_error.dart';
import '../../../../core/network/models/response_model.dart';
import '../../domain/parameters/filter_parameters.dart';
import '../../domain/repositories/i_my_opportunities_repositories.dart';
import '../models/opportunity_model.dart';

class MyOpportunitiesRepositoriesImpl extends IMyOpportunitiesRepositories {
  final IMyOpportunitiesDataSource iMyOpportunitiesDataSource;

  MyOpportunitiesRepositoriesImpl({required this.iMyOpportunitiesDataSource});

  @override
  Future<Either<String, List<OpportunityEntity>>> getMyOpportunities(
      FilterParameters params) async {
    try {
      final response =
          await iMyOpportunitiesDataSource.getMyOpportunities(params);
      if (!response.success) {
        return Left(response.message ?? "get MyOpportunities failed");
      }
      final List<Map<String, dynamic>> opportunities = [
        {
          "id": "opp_001",
          "isFollowed": true,
          "client": {
            "id": '1',
            "clientName": "Tech Solutions Inc.",
            "email": "contact@techsolutions.com",
            "address": "123 Tech Street",
            "clientLocationLat": 40.7128,
            "clientLocationLng": -74.0060,
            "phoneNumber": "+1234567890",
            "registrationNumber": 1001,
            "responsiblePerson": "John Smith",
            "responsiblePersonPhone": "+1987654321",
            "businessSector": "Technology",
            "city": "New York",
            "informationSource": "Referral",
            "dataUrl": "https://example.com/properties/skyline-towers",
          },
          "property": {
            "id": "prop_001",
            "propertyName": "Skyline Towers",
            "unitName": "Unit 15B",
            "realEstateType": 1,
            "maxPrice": 750000.0,
            "minPrice": 500000.0,
            "dataUrl": "https://example.com/properties/skyline-towers",
            "propertyLocationLat": 40.7589,
            "propertyLocationLng": -73.9851
          }
        },
        {
          "id": "opp_002",
          "isFollowed": false,
          "client": {
            "id": '2',
            "dataUrl": "https://example.com/properties/skyline-towers",
            "clientName": "Green Energy Ltd.",
            "email": "info@greenenergy.com",
            "address": "456 Eco Avenue",
            "clientLocationLat": 34.0522,
            "clientLocationLng": -118.2437,
            "phoneNumber": "+1234567891",
            "registrationNumber": 1002,
            "responsiblePerson": "Sarah Johnson",
            "responsiblePersonPhone": "+1987654322",
            "businessSector": "Energy",
            "city": "Los Angeles",
            "informationSource": "Website"
          },
          "property": {
            "id": "prop_002",
            "propertyName": "Ocean View Apartments",
            "unitName": "Apartment 304",
            "realEstateType": 0,
            "maxPrice": 3500.0,
            "minPrice": 2800.0,
            "dataUrl": "https://example.com/properties/ocean-view",
            "propertyLocationLat": 34.0089,
            "propertyLocationLng": -118.4963
          }
        },
        {
          "id": "opp_003",
          "isFollowed": true,
          "client": {
            "id": '3',
            "clientName": "Global Logistics",
            "email": "support@globallogistics.com",
            "address": "789 Shipping Lane",
            "clientLocationLat": 41.8781,
            "clientLocationLng": -87.6298,
            "phoneNumber": "+1234567892",
            "registrationNumber": 1003,
            "responsiblePerson": "Mike Wilson",
            "responsiblePersonPhone": "+1987654323",
            "businessSector": "Logistics",
            "city": "Chicago",
            "dataUrl": "https://example.com/properties/skyline-towers",
            "informationSource": "Trade Show"
          },
          "property": {
            "dataUrl": "https://example.com/properties/skyline-towers",
            "id": "prop_003",
            "propertyName": "Downtown Loft",
            "unitName": "Loft #5",
            "realEstateType": 1,
            "maxPrice": 425000.0,
            "minPrice": 395000.0,
            "propertyLocationLat": 41.8837,
            "propertyLocationLng": -87.6324
          }
        },
        {
          "id": "opp_004",
          "isFollowed": false,
          "client": {
            "id": '4',
            "clientName": "Healthcare Partners",
            "email": "admin@healthcarepartners.org",
            "address": "321 Medical Drive",
            "phoneNumber": "+1234567893",
            "registrationNumber": 1004,
            "responsiblePerson": "Dr. Emily Chen",
            "responsiblePersonPhone": "+1987654324",
            "businessSector": "Healthcare",
            "city": "Boston",
            "dataUrl": "https://example.com/properties/skyline-towers",
            "informationSource": "Email Campaign"
          },
          "property": {
            "id": "prop_004",
            "propertyName": "Garden Villas",
            "unitName": "Villa 12",
            "realEstateType": 0,
            "maxPrice": 5200.0,
            "minPrice": 4500.0,
            "dataUrl": "https://example.com/properties/garden-villas",
            "propertyLocationLat": 37.3382,
            "propertyLocationLng": -121.8863
          }
        },
        {
          "id": "opp_005",
          "isFollowed": true,
          "client": {
            "id": '5',
            "clientName": "Creative Designs Studio",
            "email": "hello@creativedesigns.com",
            "address": "555 Art Boulevard",
            "clientLocationLat": 37.7749,
            "clientLocationLng": -122.4194,
            "phoneNumber": "+1234567894",
            "responsiblePerson": "Alex Rodriguez",
            "responsiblePersonPhone": "+1987654325",
            "businessSector": "Design",
            "city": "San Francisco",
            "dataUrl": "https://example.com/properties/skyline-towers",
            "informationSource": "Social Media"
          },
          "property": {
            "id": "prop_005",
            "propertyName": "Mountain Retreat",
            "unitName": "Cabin A",
            "realEstateType": 1,
            "maxPrice": 1200000.0,
            "minPrice": 950000.0,
            "dataUrl": "https://example.com/properties/mountain-retreat",
            "propertyLocationLat": 39.7392,
            "propertyLocationLng": -104.9903
          }
        }
      ];
      final List<OpportunityModel> models =
          OpportunityModel.fromJsonList(opportunities);
      final List<OpportunityEntity> entities =
          OpportunityEntity.fromModelList(models);
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

  @override
  Future<Either<String, List<OpportunityEntity>>> postCompleteOpportunity(
      PostOpportunityParameters params) async {
    try {
      final response =
          await iMyOpportunitiesDataSource.postCompleteOpportunity(params);
      if (!response.success) {
        return Left(response.message ?? "get MyOpportunities failed");
      }
      final List<Map<String, dynamic>> opportunities = [
        {
          "id": "opp_001",
          "isFollowed": true,
          "client": {
            "id": '1',
            "clientName": "Tech Solutions Inc.",
            "email": "contact@techsolutions.com",
            "address": "123 Tech Street",
            "clientLocationLat": 40.7128,
            "clientLocationLng": -74.0060,
            "phoneNumber": "+1234567890",
            "registrationNumber": 1001,
            "responsiblePerson": "John Smith",
            "responsiblePersonPhone": "+1987654321",
            "businessSector": "Technology",
            "city": "New York",
            "informationSource": "Referral",
            "dataUrl": "https://example.com/properties/skyline-towers",
          },
          "property": {
            "id": "prop_001",
            "propertyName": "Skyline Towers",
            "unitName": "Unit 15B",
            "realEstateType": 1,
            "maxPrice": 750000.0,
            "minPrice": 500000.0,
            "dataUrl": "https://example.com/properties/skyline-towers",
            "propertyLocationLat": 40.7589,
            "propertyLocationLng": -73.9851
          }
        },
        {
          "id": "opp_002",
          "isFollowed": false,
          "client": {
            "id": '2',
            "dataUrl": "https://example.com/properties/skyline-towers",
            "clientName": "Green Energy Ltd.",
            "email": "info@greenenergy.com",
            "address": "456 Eco Avenue",
            "clientLocationLat": 34.0522,
            "clientLocationLng": -118.2437,
            "phoneNumber": "+1234567891",
            "registrationNumber": 1002,
            "responsiblePerson": "Sarah Johnson",
            "responsiblePersonPhone": "+1987654322",
            "businessSector": "Energy",
            "city": "Los Angeles",
            "informationSource": "Website"
          },
          "property": {
            "id": "prop_002",
            "propertyName": "Ocean View Apartments",
            "unitName": "Apartment 304",
            "realEstateType": 0,
            "maxPrice": 3500.0,
            "minPrice": 2800.0,
            "dataUrl": "https://example.com/properties/ocean-view",
            "propertyLocationLat": 34.0089,
            "propertyLocationLng": -118.4963
          }
        },
        {
          "id": "opp_003",
          "isFollowed": true,
          "client": {
            "id": '3',
            "clientName": "Global Logistics",
            "email": "support@globallogistics.com",
            "address": "789 Shipping Lane",
            "clientLocationLat": 41.8781,
            "clientLocationLng": -87.6298,
            "phoneNumber": "+1234567892",
            "registrationNumber": 1003,
            "responsiblePerson": "Mike Wilson",
            "responsiblePersonPhone": "+1987654323",
            "businessSector": "Logistics",
            "city": "Chicago",
            "dataUrl": "https://example.com/properties/skyline-towers",
            "informationSource": "Trade Show"
          },
          "property": {
            "dataUrl": "https://example.com/properties/skyline-towers",
            "id": "prop_003",
            "propertyName": "Downtown Loft",
            "unitName": "Loft #5",
            "realEstateType": 1,
            "maxPrice": 425000.0,
            "minPrice": 395000.0,
            "propertyLocationLat": 41.8837,
            "propertyLocationLng": -87.6324
          }
        },
        {
          "id": "opp_004",
          "isFollowed": false,
          "client": {
            "id": '4',
            "clientName": "Healthcare Partners",
            "email": "admin@healthcarepartners.org",
            "address": "321 Medical Drive",
            "phoneNumber": "+1234567893",
            "registrationNumber": 1004,
            "responsiblePerson": "Dr. Emily Chen",
            "responsiblePersonPhone": "+1987654324",
            "businessSector": "Healthcare",
            "city": "Boston",
            "dataUrl": "https://example.com/properties/skyline-towers",
            "informationSource": "Email Campaign"
          },
          "property": {
            "id": "prop_004",
            "propertyName": "Garden Villas",
            "unitName": "Villa 12",
            "realEstateType": 0,
            "maxPrice": 5200.0,
            "minPrice": 4500.0,
            "dataUrl": "https://example.com/properties/garden-villas",
            "propertyLocationLat": 37.3382,
            "propertyLocationLng": -121.8863
          }
        },
        {
          "id": "opp_005",
          "isFollowed": true,
          "client": {
            "id": '5',
            "clientName": "Creative Designs Studio",
            "email": "hello@creativedesigns.com",
            "address": "555 Art Boulevard",
            "clientLocationLat": 37.7749,
            "clientLocationLng": -122.4194,
            "phoneNumber": "+1234567894",
            "responsiblePerson": "Alex Rodriguez",
            "responsiblePersonPhone": "+1987654325",
            "businessSector": "Design",
            "city": "San Francisco",
            "dataUrl": "https://example.com/properties/skyline-towers",
            "informationSource": "Social Media"
          },
          "property": {
            "id": "prop_005",
            "propertyName": "Mountain Retreat",
            "unitName": "Cabin A",
            "realEstateType": 1,
            "maxPrice": 1200000.0,
            "minPrice": 950000.0,
            "dataUrl": "https://example.com/properties/mountain-retreat",
            "propertyLocationLat": 39.7392,
            "propertyLocationLng": -104.9903
          }
        }
      ];
      final List<OpportunityModel> models =
          OpportunityModel.fromJsonList(opportunities);
      final List<OpportunityEntity> entities =
          OpportunityEntity.fromModelList(models);
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
