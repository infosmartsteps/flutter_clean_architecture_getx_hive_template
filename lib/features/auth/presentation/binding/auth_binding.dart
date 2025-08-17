import 'package:get/get.dart';
import '../../../../core/network/i_rest.dart';
import '../../data/datasources/i_log_in_remote_data_source.dart';
import '../../data/datasources/logIn_remote_data_source_impl.dart';
import '../../data/repositories/log_in_repository_impl.dart';
import '../../domain/repositories/i_log_in_repository.dart';
import '../../domain/use_cases/login_use_case.dart';
import '../controller/auth_controller.dart';

//lib/features/auth/presentation/binding/auth_binding.dart
class AuthBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.lazyPut<ILogInRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(rest: Get.find<IRestClient>()),
    );

    // Repository
    Get.lazyPut<ILogInRepository>(
      () => LogInRepositoryImpl(Get.find<ILogInRemoteDataSource>()),
    );

    // Use case
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(repository: Get.find<ILogInRepository>()),
    );

    // Controller
    Get.lazyPut<AuthController>(
      () => AuthController(loginUseCase: Get.find<LoginUseCase>()),
    );
  }
}
