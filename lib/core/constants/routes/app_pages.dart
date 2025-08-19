import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../../features/auth/presentation/binding/auth_binding.dart';
import '../../../features/auth/presentation/screens/log_in_screen.dart';
import '../../../features/home/presentation/bindings/add_client_form_binding.dart';
import '../../../features/home/presentation/bindings/home_binding.dart';
import '../../../features/home/presentation/screens/home_screen.dart';
import '../../../features/home/presentation/screens/home_screens/add_client_screen.dart';
import '../../../features/splash/presentation/binding/splash_binding.dart';
import '../../../features/splash/presentation/screens/splash_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: AppRoutes.initialRoute(),
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.logInScreen,
      page: () => LogInScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.addClientForm,
      page: () => const AddClientScreen(),
      binding: AddClientFormBinding(),
    ),
  ];
}
