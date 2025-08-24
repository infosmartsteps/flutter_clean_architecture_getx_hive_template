import 'package:dartz/dartz.dart';

import '../entities/login_entity.dart';
import '../params/log_in_params.dart';
import '../repositories/i_log_in_repository.dart';


//lib/features/auth/domain/use_cases/login_use_case.dart
class LoginUseCase {
  final ILogInRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<String, LogInEntity>> login(LogInParameters params) async {
    return await repository.login(params);
  }
}
