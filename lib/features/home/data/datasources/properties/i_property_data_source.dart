import 'package:ksa_real_estates/core/network/models/response_model.dart';

abstract class IPropertyDataSource {
  Future<ApiResponse> getProperty();
}
