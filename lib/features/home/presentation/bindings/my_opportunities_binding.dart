import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/my_opportunities_controller.dart';
import '../../../../core/network/rest_impl.dart';
import '../../data/datasources/my_opportunities/i_my_opportunities_data_source.dart';
import '../../data/datasources/my_opportunities/my_opportunities_data_source_impl.dart';
import '../../data/repositories/my_opportunities_repositories_impl.dart';
import '../../domain/repositories/i_my_opportunities_repositories.dart';
import '../../domain/usecases/my_opportunities_use_case.dart';

class MyOpportunitiesBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.put<IMyOpportunitiesDataSource>(
        MyOpportunitiesDataSourceImpl(rest: Get.find<RestImpl>()));

    // Repository
    Get.put<IMyOpportunitiesRepositories>(MyOpportunitiesRepositoriesImpl(
        iMyOpportunitiesDataSource: Get.find<IMyOpportunitiesDataSource>()));

    // Use case
    Get.put<MyOpportunitiesUseCase>(MyOpportunitiesUseCase(
        iMyOpportunitiesRepositories:
            Get.find<IMyOpportunitiesRepositories>()));

    // Controller
    Get.put<MyOpportunitiesController>(MyOpportunitiesController(
        myOpportunitiesUseCase: Get.find<MyOpportunitiesUseCase>()));
  }
}
