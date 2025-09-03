import '../../../../config/base_url_config.dart';
import '../../../../core/network/i_rest.dart';
import '../../../../core/network/models/response_model.dart';
import '../../domain/params/log_in_params.dart';
import 'i_log_in_remote_data_source.dart';

//lib/features/auth/data/datasources/logIn_remote_data_source_impl.dart
class LoginRemoteDataSourceImpl implements ILogInRemoteDataSource {
  final IRestClient rest;

  LoginRemoteDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> login(LogInParameters params) async =>
      await rest.post(ApiEndPoints.loginEndpoint, data: params.toJson());
}
