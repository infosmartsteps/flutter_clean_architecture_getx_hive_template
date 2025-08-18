import '../../../../core/network/models/response_model.dart';
import '../../domain/params/log_in_params.dart';

abstract class ILogInRemoteDataSource {
  Future<ApiResponse> login(LogInParameters params);
}
