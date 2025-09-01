import 'package:dartz/dartz.dart';
import '../entities/property_entity.dart';
import '../parameters/filter_parameters.dart';
import '../repositories/i_entered_opportunities_repository.dart';

class EnteredOpportunitiesUseCase {
  final IEnteredOpportunitiesRepository iEnteredOpportunitiesRepository;

  EnteredOpportunitiesUseCase({required this.iEnteredOpportunitiesRepository});

  Future<Either<String, List<PropertyEntity>>> getEnteredOpportunities(FilterParameters filterParameters) async {
    return await iEnteredOpportunitiesRepository.getEnteredOpportunities(filterParameters);
  }
}
