import 'package:get/get.dart';
import '../../../../../core/network/rest_impl.dart';
import '../../../data/datasources/entered_opportunities/entered_opportunities_data_source_impl.dart';
import '../../../data/datasources/entered_opportunities/i_entered_opportunities_data_source.dart';
import '../../../data/repositories/entered_opportunities_repository_impl.dart';
import '../../../domain/repositories/i_entered_opportunities_repository.dart';
import '../../../domain/usecases/entered_opportunities_use_case.dart';
import '../../controllers/my_previous_operations_controllers/entered_opportunities_controller.dart';

class EnteredOpportunitiesBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.put<IEnteredOpportunitiesDataSource>(
        EnteredOpportunitiesDataSourceImpl(rest: Get.find<RestImpl>()));

    // Repository
    Get.put<IEnteredOpportunitiesRepository>(EnteredOpportunitiesRepositoryImpl(
        iEnteredOpportunitiesDataSource:
            Get.find<IEnteredOpportunitiesDataSource>()));

    // Use case
    Get.put<EnteredOpportunitiesUseCase>(EnteredOpportunitiesUseCase(
        iEnteredOpportunitiesRepository:
            Get.find<IEnteredOpportunitiesRepository>()));

    // Controller
    Get.put<EnteredOpportunitiesController>(EnteredOpportunitiesController(
        enteredOpportunitiesUseCase: Get.find<EnteredOpportunitiesUseCase>()));
  }
}
