import 'package:ksa_real_estates/core/network/models/response_model.dart';
import 'package:ksa_real_estates/features/auth/domain/params/log_in_params.dart';

abstract class ILogInRemoteDataSource {
  Future<ApiResponse> login(LogInParameters params);
}
