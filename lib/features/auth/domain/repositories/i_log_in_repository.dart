import 'package:dartz/dartz.dart';
import 'package:ksa_real_estates/features/auth/domain/entities/login_entity.dart';
import 'package:ksa_real_estates/features/auth/domain/params/log_in_params.dart';

//lib/features/auth/domain/repositories/i_log_in_repository.dart
abstract class ILogInRepository {
  Future<Either<String, LogInEntity>> login(LogInParameters parameters);
}
