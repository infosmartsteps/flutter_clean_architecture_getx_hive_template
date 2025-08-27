import 'package:ksa_real_estates/core/network/models/response_model.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/cities_parameters.dart';

abstract class ILookupsRemoteDataSource {
  Future<ApiResponse> getCities(CitiesParameters params);
  Future<ApiResponse> getBusinessSectors();
  Future<ApiResponse> getInformationSources();
}
