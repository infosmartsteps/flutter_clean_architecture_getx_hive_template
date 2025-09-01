import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';
import '../../../../core/network/handle_dio_error.dart';
import '../../../../core/network/models/response_model.dart';
import '../../domain/parameters/filter_parameters.dart';
import '../../domain/repositories/i_entered_clients_repository.dart';
import '../datasources/entered_clints/i_entered_clients_data_source.dart';
import '../models/client_model.dart';

class EnteredClientsRepositoryImpl extends IEnteredClientsRepository {
  final IEnteredClientsDataSource iEnteredClientsDataSource;

  EnteredClientsRepositoryImpl({required this.iEnteredClientsDataSource});

  @override
  Future<Either<String, List<ClientEntity>>> getEnteredClients(FilterParameters filterParameters) async {
    try {
      final response = await iEnteredClientsDataSource.getEnteredClients(filterParameters);
      if (!response.success) {
        return Left(response.message ?? "getCities failed");
      }
      final List<Map<String, dynamic>> clients = [
        {
          "id": 1,
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
          "informationSource": "Referral"
        },
        {
          "id": 2,
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
        {
          "id": 3,
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
          "informationSource": "Trade Show"
        },
        {
          "id": 4,
          "clientName": "Healthcare Partners",
          "email": "admin@healthcarepartners.org",
          "address": "321 Medical Drive",
          "phoneNumber": "+1234567893",
          "registrationNumber": 1004,
          "responsiblePerson": "Dr. Emily Chen",
          "responsiblePersonPhone": "+1987654324",
          "businessSector": "Healthcare",
          "city": "Boston",
          "informationSource": "Email Campaign"
        },
        {
          "id": 5,
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
          "informationSource": "Social Media"
        }
      ];
      final List<ClientModel> models = ClientModel.fromJsonList(clients);
      final List<ClientEntity> entities = ClientEntity.fromModelList(models);
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
