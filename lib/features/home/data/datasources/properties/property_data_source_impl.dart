import 'package:ksa_real_estates/config/base_url_config.dart';
import 'package:ksa_real_estates/core/network/models/response_model.dart';
import '../../../../../core/network/i_rest.dart';
import 'i_property_data_source.dart';

class PropertyDataSourceImpl extends IPropertyDataSource {
  final IRestClient rest;

  PropertyDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> getProperty() async {
    return await rest.get(ApiEndPoints.getProperty);
  }
}
