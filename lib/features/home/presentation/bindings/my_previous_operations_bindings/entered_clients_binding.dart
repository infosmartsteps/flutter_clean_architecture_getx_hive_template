import 'package:get/get.dart';
import '../../../../../core/network/rest_impl.dart';
import '../../../data/datasources/entered_clints/entered_clients_data_source_impl.dart';
import '../../../data/datasources/entered_clints/i_entered_clients_data_source.dart';
import '../../../data/repositories/entered_clients_repository_impl.dart';
import '../../../domain/repositories/i_entered_clients_repository.dart';
import '../../../domain/usecases/entered_clients_use_case.dart';
import '../../controllers/my_previous_operations_controllers/entered_clients_controller.dart';

class EnteredClientsBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.put<IEnteredClientsDataSource>(
        EnteredClientsDataSourceImpl(rest: Get.find<RestImpl>()));

    // Repository
    Get.put<IEnteredClientsRepository>(EnteredClientsRepositoryImpl(
        iEnteredClientsDataSource: Get.find<IEnteredClientsDataSource>()));

    // Use case
    Get.put<EnteredClientsUseCase>(EnteredClientsUseCase(
        iEnteredClientsRepository: Get.find<IEnteredClientsRepository>()));

    // Controller
    Get.put<EnteredClientsController>(EnteredClientsController(
        enteredClientsUseCase: Get.find<EnteredClientsUseCase>()));
  }
}
