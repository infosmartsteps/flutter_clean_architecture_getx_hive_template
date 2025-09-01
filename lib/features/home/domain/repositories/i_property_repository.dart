import 'package:dartz/dartz.dart';

import '../entities/property_entity.dart';

abstract class IPropertyRepository {
  Future<Either<String, List<PropertyEntity>>> getProperty({String? value});
}
