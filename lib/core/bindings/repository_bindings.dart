import 'package:get/get.dart';

// import '../../data/remote/domain/repositories/auth_repository.dart';
// import '../../data/remote/domain/repositories/auth_repository_impl.dart';
// Import other repositories as needed

class RepositoryBindings implements Bindings {
  @override
  void dependencies() {
    // Get.lazyPut<AuthRepository>(
    //       () => AuthRepositoryImpl(
    //     dio: Get.find<Dio>(tag: 'dio'),
    //     localStorage: Get.find<LocalStorageRepository>(tag: 'localStorage'),
    //   ),
    //   fenix: true,
    // );

    // Add other repository bindings
  }
}