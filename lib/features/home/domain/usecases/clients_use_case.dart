import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/home/domain/entities/client_entity.dart';

import '../repositories/i_clients_repository.dart';

class ClientsUseCase {
  final IClientsRepository iClientsRepository;

  ClientsUseCase({required this.iClientsRepository});

  Future<Either<String, List<ClientEntity>>> getClients() async {
    return await iClientsRepository.getClients();
  }
}
