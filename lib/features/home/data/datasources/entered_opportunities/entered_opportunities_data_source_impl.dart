import '../../../../../config/base_url_config.dart';
import '../../../../../core/network/i_rest.dart';
import '../../../../../core/network/models/response_model.dart';
import '../../../domain/parameters/filter_parameters.dart';
import 'i_entered_opportunities_data_source.dart';

class EnteredOpportunitiesDataSourceImpl
    extends IEnteredOpportunitiesDataSource {
  IRestClient rest;

  EnteredOpportunitiesDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> getEnteredOpportunities(
      FilterParameters filterParameters) async {
    return await rest.get(ApiEndPoints.getEnteredOpportunities,
        queryParameters: filterParameters.toJson());
  }
}
