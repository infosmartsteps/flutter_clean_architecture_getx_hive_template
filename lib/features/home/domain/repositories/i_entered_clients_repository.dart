import 'package:dartz/dartz.dart';
import '../entities/client_entity.dart';
import '../parameters/filter_parameters.dart';

abstract class IEnteredClientsRepository {
  Future<Either<String, List<ClientEntity>>> getEnteredClients(FilterParameters filterParameters);
}
