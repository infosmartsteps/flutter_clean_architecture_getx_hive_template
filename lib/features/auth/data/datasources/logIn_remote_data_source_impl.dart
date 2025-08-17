import 'package:ksa_real_estates/core/network/i_rest.dart';
import 'package:ksa_real_estates/core/network/models/response_model.dart';
import 'package:ksa_real_estates/features/auth/data/datasources/i_log_in_remote_data_source.dart';
import 'package:ksa_real_estates/features/auth/domain/params/log_in_params.dart';

import '../../../../config/base_url_config.dart';

//lib/features/auth/data/datasources/logIn_remote_data_source_impl.dart
class LoginRemoteDataSourceImpl implements ILogInRemoteDataSource {
  final IRestClient rest;

  LoginRemoteDataSourceImpl({required this.rest});

  @override
  Future<ApiResponse> login(LogInParameters params) async {
    return await rest.post(BaseUrlConfig.loginEndpoint, data: params);
  }
}
