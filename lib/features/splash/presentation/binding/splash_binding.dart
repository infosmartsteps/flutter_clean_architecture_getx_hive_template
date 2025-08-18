import 'package:get/get.dart';
import '../controller/splash_controller.dart';

//lib/features/splash/presentation/binding/splash_binding.dart
class SplashBinding extends Bindings {
  @override
  void dependencies() async {
    Get.put<SplashController>(SplashController());
  }
}
