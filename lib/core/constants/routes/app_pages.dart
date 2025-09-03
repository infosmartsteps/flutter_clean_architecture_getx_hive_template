import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

// Splash
import '../../../features/splash/presentation/binding/splash_binding.dart';
import '../../../features/splash/presentation/screens/splash_screen.dart';

// Auth
import '../../../features/auth/presentation/binding/auth_binding.dart';
import '../../../features/auth/presentation/screens/log_in_screen.dart';

// Home
import '../../../features/home/presentation/screens/home_screen.dart';
import '../../../features/home/presentation/bindings/home_binding.dart';

// Add Client
import '../../../features/home/presentation/bindings/add_client_form_binding.dart';
import '../../../features/home/presentation/bindings/map_binding.dart';
import '../../../features/home/presentation/screens/home_screens/add_client_screen.dart';
import '../../../features/home/presentation/widgets/add_client/choose_location_widget.dart';

// Interested Clients
import '../../../features/home/presentation/bindings/interested_clients_binding.dart';
import '../../../features/home/presentation/screens/home_screens/interested_clients_screen.dart';
import '../../../features/home/presentation/widgets/interested_clients/client_information_screen.dart';
import '../../../features/home/presentation/widgets/interested_clients/property_information_screen.dart';

// Available Opportunities
import '../../../features/home/presentation/bindings/available_opportunities_binding.dart';
import '../../../features/home/presentation/screens/home_screens/available_opportunities_screen.dart';
import '../../../features/home/presentation/widgets/available_opportunities/interested_client_screen.dart';

// My Opportunities
import '../../../features/home/presentation/bindings/my_opportunities_binding.dart';
import '../../../features/home/presentation/screens/home_screens/my_opportunities_screen.dart';
import '../../../features/home/presentation/widgets/my_opportunities/opportunity_information_screen.dart';

// My Previous Operations
import '../../../features/home/presentation/screens/home_screens/my_previous_operations_screen.dart';
import '../../../features/home/presentation/bindings/my_previous_operations_bindings/entered_clients_binding.dart';
import '../../../features/home/presentation/bindings/my_previous_operations_bindings/entered_opportunities_binding.dart';
import '../../../features/home/presentation/widgets/my_previous_operations/entered_clients_screen.dart';
import '../../../features/home/presentation/widgets/my_previous_operations/entered_opportunities_screen.dart';

import 'app_routes.dart';

class AppPages {
  static final List<GetPage<dynamic>> pages = [
    // splash
    GetPage(
      name: AppRoutes.initialRoute(),
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    //login
    GetPage(
      name: AppRoutes.logInScreen,
      page: () => LogInScreen(),
      binding: AuthBinding(),
      transition: Transition.rightToLeft,
    ),
    //=========================== ** home screens ** ===========================
    GetPage(
      name: AppRoutes.homeScreen,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    // ================ addClient screens ===============
    GetPage(
      name: AppRoutes.addClientForm,
      page: () => const AddClientScreen(),
      binding: AddClientFormBinding(),
    ),
    GetPage(
      name: AppRoutes.chooseLocationScreen,
      page: () => const ChooseLocationScreen(),
      binding: MapBinding(isLive: true),
    ),
    //============== interested Clients Screens ==============
    GetPage(
      name: AppRoutes.interestedClientsScreen,
      page: () => const InterestedClientsScreen(),
      binding: InterestedClientsBinding(),
    ),
    GetPage(
      name: AppRoutes.propertyInformationScreen,
      page: () => const PropertyInformationScreen(),
      binding: MapBinding(),
    ),
    GetPage(
      name: AppRoutes.clientInformationScreen,
      page: () => const ClientInformationScreen(),
      binding: MapBinding(),
    ),
    // =============== available Opportunities Screens ===============
    GetPage(
      name: AppRoutes.availableOpportunitiesScreen,
      page: () => const AvailableOpportunitiesScreen(),
      binding: AvailableOpportunitiesBinding(),
    ),
    GetPage(
      name: AppRoutes.interestedClientScreen,
      page: () => const InterestedClientScreen(),
      binding: AvailableOpportunitiesBinding(),
    ),
    // =============== my Previous Operations Screens ===============
    GetPage(
      name: AppRoutes.myPreviousOperationsScreen,
      page: () => const MyPreviousOperationsScreen(),
    ),
    GetPage(
      name: AppRoutes.enteredClientsScreen,
      page: () => const EnteredClientsScreen(),
      binding: EnteredClientsBinding(),
    ),
    GetPage(
      name: AppRoutes.enteredOpportunitiesScreen,
      page: () => const EnteredOpportunitiesScreen(),
      binding: EnteredOpportunitiesBinding(),
    ),
    // =============== my Opportunities Screens ===============
    GetPage(
      name: AppRoutes.myOpportunitiesScreen,
      page: () => const MyOpportunitiesScreen(),
      binding: MyOpportunitiesBinding(),
    ),
    GetPage(
      name: AppRoutes.opportunityInformationScreen,
      page: () => const OpportunityInformationScreen(),
      binding: MyOpportunitiesBinding(),
    ),
  ];
}
