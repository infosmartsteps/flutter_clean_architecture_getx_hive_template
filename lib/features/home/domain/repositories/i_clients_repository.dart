import 'package:dartz/dartz.dart';

import '../entities/client_entity.dart';

abstract class IClientsRepository {
  Future<Either<String, List<ClientEntity>>> getClients();
}
