import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

import '../../features/auth/presentation/binding/login_binding.dart';
import '../../features/auth/presentation/screens/log_in_screen.dart';
import '../../features/splash/presentation/binding/splash_binding.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';
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
      page: () => const LoginScreen(),
      binding: LoginBinding(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.home,
    //   page: () => const HomeScreen(),
    //   bindings: [
    //     HomeBinding(),
    //     DashboardBinding(),
    //   ],
    // ),
  ];
}