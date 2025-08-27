import 'package:ksa_real_estates/config/base_url_config.dart';
import 'package:ksa_real_estates/core/network/i_rest.dart';
import 'package:ksa_real_estates/core/network/models/response_model.dart';

import 'i_clients_data_source.dart';

class ClientsDataSourceImpl extends IClientsDataSource {
  IRestClient rest;

  ClientsDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> getClients() async {
    return await rest.get(ApiEndPoints.getClients);
  }
}
