// features/auth/data/repositories/log_in_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:ksa_real_estates/features/auth/data/models/log_in_model.dart';
import 'package:ksa_real_estates/features/auth/domain/params/log_in_params.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/i_log_in_repository.dart';
import '../datasources/i_log_in_remote_data_source.dart';

//lib/features/auth/data/repositories/log_in_repository_impl.dart
class LogInRepositoryImpl implements ILogInRepository {
  final ILogInRemoteDataSource remoteDataSource;

  LogInRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, LogInEntity>> login(LogInParameters parameters) async {
    try {
      final response = await remoteDataSource.login(parameters);

      if (!response.success) {
        return Left(response.message ?? "Login failed");
      }
      final loginResponse = LogInModel.fromJson(response.data);
      return Right(LogInEntity.fromResponse(loginResponse));
    } on DioException catch (e) {
      return Left(e.message ?? "Network error");
    } catch (e) {
      return Left("An unexpected error occurred");
    }
  }
}
