import 'package:get/get.dart';
import '../../../../core/utils/responsive_size_helper.dart';
import '../controller/splash_controller.dart';
//lib/features/splash/presentation/binding/splash_binding.dart
class SplashBinding extends Bindings {
  @override
  void dependencies() {
    SizeConfig.init(); // Initialize responsive sizing
    // fenix: true is good if you expect the controller to be recreated
    Get.lazyPut<SplashController>(
          () => SplashController(),
      // fenix: true,
    );
  }
}
