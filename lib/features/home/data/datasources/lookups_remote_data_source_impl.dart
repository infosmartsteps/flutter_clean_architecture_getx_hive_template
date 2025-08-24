import 'package:ksa_real_estates/config/base_url_config.dart';
import 'package:ksa_real_estates/core/network/i_rest.dart';
import 'package:ksa_real_estates/core/network/models/response_model.dart';

import 'package:ksa_real_estates/features/home/domain/parameters/cities_parameters.dart';

import 'i_lookups_remote_data_source.dart';

class LookupsRemoteDataSourceImpl extends ILookupsRemoteDataSource {
  final IRestClient rest;

  LookupsRemoteDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> getCities(CitiesParameters params) async {
    return await rest.post(ApiEndPoints.getCitiesEndpoint,
        data: params.toJson());
  }

  @override
  Future<ApiResponse> getBusinessSectors() async {
    return await rest.post(ApiEndPoints.getBusinessSectorsEndpoint);
  }

  @override
  Future<ApiResponse> getInformationSources() async {
    return await rest.post(ApiEndPoints.getInformationSourcesEndpoint);
  }
}
