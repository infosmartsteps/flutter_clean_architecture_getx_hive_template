import 'package:ksa_real_estates/core/network/models/response_model.dart';

import '../../../domain/parameters/filter_parameters.dart';

abstract class IEnteredClientsDataSource {
  Future<ApiResponse> getEnteredClients(FilterParameters filterParameters);
}
