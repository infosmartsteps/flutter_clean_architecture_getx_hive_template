import 'package:ksa_real_estates/config/base_url_config.dart';
import 'package:ksa_real_estates/core/network/i_rest.dart';
import 'package:ksa_real_estates/core/network/models/response_model.dart';

import '../../../domain/parameters/filter_parameters.dart';
import 'i_entered_clients_data_source.dart';

class EnteredClientsDataSourceImpl extends IEnteredClientsDataSource {
  IRestClient rest;

  EnteredClientsDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> getEnteredClients(
      FilterParameters filterParameters) async {
    return await rest.get(ApiEndPoints.getEnteredClients,
        queryParameters: filterParameters.toJson());
  }
}
