import 'package:dartz/dartz.dart';
import '../entities/lookups_entity.dart';
import '../parameters/cities_parameters.dart';

//lib/features/home/domain/repositories/lookups_repositories_impl.dart
abstract class ILookupsRepositories {
  Future<Either<String, List<LookupsEntity>>> getCities(
      CitiesParameters params);

  Future<Either<String, List<LookupsEntity>>> getBusinessSectors();

  Future<Either<String, List<LookupsEntity>>> getInformationSources();
}
