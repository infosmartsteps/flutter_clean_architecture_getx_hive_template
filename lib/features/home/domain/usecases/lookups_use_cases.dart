import 'package:dartz/dartz.dart';
import '../entities/lookups_entity.dart';
import '../parameters/cities_parameters.dart';
import '../repositories/i_lookups_repositories.dart';

//lib/features/home/domain/use_cases/look_ups_use_cases.dart
class LookUpsUseCases {
  final ILookupsRepositories lookupsRepositories;

  LookUpsUseCases({required this.lookupsRepositories});

  Future<Either<String, List<LookupsEntity>>> getCountries(
      CitiesParameters params) async {
    return await lookupsRepositories.getCities(params);
  }

  Future<Either<String, List<LookupsEntity>>> getBusinessSectors() async {
    return await lookupsRepositories.getBusinessSectors();
  }
  Future<Either<String, List<LookupsEntity>>> getInformationSources() async {
    return await lookupsRepositories.getInformationSources();
  }
}
