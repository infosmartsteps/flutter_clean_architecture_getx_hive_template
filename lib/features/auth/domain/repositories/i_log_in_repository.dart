import 'package:dartz/dartz.dart';
import '../entities/login_entity.dart';
import '../params/log_in_params.dart';

//lib/features/auth/domain/repositories/i_log_in_repository.dart
abstract class ILogInRepository {
  Future<Either<String, LogInEntity>> login(LogInParameters parameters);
}
