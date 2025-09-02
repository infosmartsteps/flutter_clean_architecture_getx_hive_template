import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/home/domain/entities/opportunity_entity.dart';

import '../parameters/filter_parameters.dart';
import '../parameters/post_opportunity_parameters.dart';
import '../repositories/i_my_opportunities_repositories.dart';

class MyOpportunitiesUseCase {
  final IMyOpportunitiesRepositories iMyOpportunitiesRepositories;

  MyOpportunitiesUseCase({required this.iMyOpportunitiesRepositories});

  Future<Either<String, List<OpportunityEntity>>> getMyOpportunities(
      FilterParameters params) async {
    return await iMyOpportunitiesRepositories.getMyOpportunities(params);
  }

  Future<Either<String, List<OpportunityEntity>>> postCompleteOpportunity(
      PostOpportunityParameters params) async {
    return await iMyOpportunitiesRepositories.postCompleteOpportunity(params);
  }
}
