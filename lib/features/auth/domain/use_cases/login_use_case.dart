import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/auth/domain/entities/login_entity.dart';
import 'package:ksa_real_estates/features/auth/domain/params/log_in_params.dart';
import 'package:ksa_real_estates/features/auth/domain/repositories/i_log_in_repository.dart';

//lib/features/auth/domain/use_cases/login_use_case.dart
class LoginUseCase {
  final ILogInRepository repository;

  LoginUseCase({required this.repository});

  Future<Either<String, LogInEntity>> login(LogInParameters params) async {
    return await repository.login(params);
  }
}
