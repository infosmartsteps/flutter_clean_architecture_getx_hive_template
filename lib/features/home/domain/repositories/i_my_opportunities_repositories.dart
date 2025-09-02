import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/home/domain/entities/opportunity_entity.dart';

import '../parameters/filter_parameters.dart';
import '../parameters/post_opportunity_parameters.dart';

abstract class IMyOpportunitiesRepositories {
  Future<Either<String, List<OpportunityEntity>>> getMyOpportunities(
      FilterParameters params);

  Future<Either<String, List<OpportunityEntity>>> postCompleteOpportunity(
      PostOpportunityParameters params);
}
