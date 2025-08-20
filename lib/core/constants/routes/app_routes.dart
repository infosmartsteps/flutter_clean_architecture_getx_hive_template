class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const logInScreen = "/logInScreen";
  static const homeScreen = "/homeScreen";
  static const addClientForm = "/addClientForm";
  static const mapScreen = "/mapScreen";

  static String initialRoute() {
    return splashScreen;
  }

// static Map<String, Widget Function(BuildContext)> appRoutes() {
//   return {
//     splashScreen: (context) => const SplashScreen(),
//     // logInScreen: (context) => const LogInScreen(),
//   };
// }
}
