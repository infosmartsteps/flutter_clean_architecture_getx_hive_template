import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';

import '../parameters/filter_parameters.dart';
import '../repositories/i_entered_clients_repository.dart';

class EnteredClientsUseCase {
  final IEnteredClientsRepository iEnteredClientsRepository;

  EnteredClientsUseCase({required this.iEnteredClientsRepository});

  Future<Either<String, List<ClientEntity>>> getEnteredClients(
      FilterParameters filterParameters) async {
    return await iEnteredClientsRepository.getEnteredClients(filterParameters);
  }
}
