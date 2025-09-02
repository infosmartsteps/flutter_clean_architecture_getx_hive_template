class AppRoutes {
  static const splashScreen = "/splashScreen";
  static const logInScreen = "/logInScreen";
  static const homeScreen = "/homeScreen";
  static const addClientForm = "/addClientForm";
  static const chooseLocationScreen = "/ChooseLocationScreen";
  static const interestedClientsScreen = "/interestedClientsScreen";
  static const propertyInformationScreen = "/propertyInformationScreen";
  static const clientInformationScreen = "/clientInformationScreen";
  static const availableOpportunitiesScreen = "/availableOpportunitiesScreen";
  static const interestedClientScreen = "/interestedClientScreen";
  static const myPreviousOperationsScreen = "/myPreviousOperationsScreen";
  static const enteredClientsScreen = "/enteredClientsScreen";
  static const enteredOpportunitiesScreen = "/enteredOpportunitiesScreen";
  static const myOpportunitiesScreen = "/myOpportunitiesScreen";
  static const opportunityInformationScreen = "/opportunityInformationScreen";

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
