import 'package:ksa_real_estates/core/network/models/response_model.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/post_opportunity_parameters.dart';

import '../../../../../config/base_url_config.dart';
import '../../../../../core/network/i_rest.dart';
import '../../../domain/parameters/filter_parameters.dart';
import 'i_my_opportunities_data_source.dart';

class MyOpportunitiesDataSourceImpl extends IMyOpportunitiesDataSource {
  final IRestClient rest;

  MyOpportunitiesDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> getMyOpportunities(FilterParameters params) async {
    return await rest.post(ApiEndPoints.getMyOpportunities,
        queryParameters: params.toJson());
  }

  @override
  Future<ApiResponse> postCompleteOpportunity(
      PostOpportunityParameters params) async {
    return await rest.post(ApiEndPoints.postCompleteOpportunity,
        data: params.toJson());
  }
}
