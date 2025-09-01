import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/home/domain/entities/property_entity.dart';

import '../repositories/i_property_repository.dart';

class PropertyUseCase {
  final IPropertyRepository iPropertyRepository;

  PropertyUseCase({required this.iPropertyRepository});

  Future<Either<String, List<PropertyEntity>>> getProperty({String? value}) async {
    return await iPropertyRepository.getProperty(value: value);
  }
}
