import 'package:get/get.dart';

import '../../domain/use_cases/login_use_case.dart';
import '../controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginUseCase>(
      () => LoginUseCase(),
    );
    Get.lazyPut<AuthController>(
      () => AuthController(loginUseCase: Get.find<LoginUseCase>()),
    );
  }
}
