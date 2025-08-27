import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/home/domain/entities/opportunity_entity.dart';

import '../repositories/i_opportunities_repository.dart';

class OpportunitiesUseCase {
  final IOpportunitiesRepository iOpportunitiesRepository;

  OpportunitiesUseCase({required this.iOpportunitiesRepository});

  Future<Either<String, List<OpportunityEntity>>> getOpportunities() async {
    return await iOpportunitiesRepository.getOpportunities();
  }
}
