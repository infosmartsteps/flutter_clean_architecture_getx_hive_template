import 'package:ksa_real_estates/core/network/models/response_model.dart';

import '../../../../../config/base_url_config.dart';
import '../../../../../core/network/i_rest.dart';
import 'i_opportunities_data_source.dart';

class OpportunitiesDataSourceImpl extends IOpportunitiesDataSource {
  final IRestClient rest;

  OpportunitiesDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> getOpportunities() async {
    return await rest.post(ApiEndPoints.getOpportunities);
  }
}
