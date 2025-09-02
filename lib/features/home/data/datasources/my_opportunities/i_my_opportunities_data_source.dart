import 'package:ksa_real_estates/core/network/models/response_model.dart';

import '../../../domain/parameters/filter_parameters.dart';
import '../../../domain/parameters/post_opportunity_parameters.dart';

abstract class IMyOpportunitiesDataSource {
  Future<ApiResponse> getMyOpportunities(FilterParameters params);
  Future<ApiResponse> postCompleteOpportunity(PostOpportunityParameters params);
}
