import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';

import '../parameters/filter_parameters.dart';

abstract class IEnteredOpportunitiesRepository {
  Future<Either<String, List<PropertyEntity>>> getEnteredOpportunities(
      FilterParameters filterParameters);
}
