import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/data/local/storage_helper.dart';
import '../../../../core/network/handle_dio_error.dart';
import '../../../../core/network/models/response_model.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/params/log_in_params.dart';
import '../../domain/repositories/i_log_in_repository.dart';
import '../datasources/i_log_in_remote_data_source.dart';
import '../models/log_in_model.dart';

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
      final LogInModel loginResponse = LogInModel.fromJson(response.data);
      await StorageHelper().setUser(loginResponse);
      return Right(LogInEntity.fromResponse(loginResponse));
    } on DioException catch (e) {
      final apiResponse = handleDioError(e);
      return Left(apiResponse.message ?? "Network error");
    } on ApiResponse catch (e) {
      return Left(e.message ?? "API error");
    } catch (e) {
      return Left("Unexpected error: ${e.toString()}");
    }
  }
}
