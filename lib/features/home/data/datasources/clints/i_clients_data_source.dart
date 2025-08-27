import 'package:ksa_real_estates/core/network/models/response_model.dart';

abstract class IClientsDataSource {
  Future<ApiResponse> getClients();
}
