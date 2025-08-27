import 'package:dartz/dartz.dart';

import '../entities/opportunity_entity.dart';

abstract class IOpportunitiesRepository {
  Future<Either<String, List<OpportunityEntity>>> getOpportunities();
}
