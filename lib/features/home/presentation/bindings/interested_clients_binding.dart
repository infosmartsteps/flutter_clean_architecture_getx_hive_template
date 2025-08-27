import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/data/datasources/opportunities/i_opportunities_data_source.dart';
import 'package:ksa_real_estates/features/home/domain/repositories/i_opportunities_repository.dart';
import 'package:ksa_real_estates/features/home/domain/usecases/opportunities_use_case.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/interested_clients_controller.dart';

import '../../../../core/network/rest_impl.dart';
import '../../data/datasources/opportunities/opportunities_data_source_impl.dart';
import '../../data/repositories/opportunities_repository_impl.dart';

class InterestedClientsBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.put<IOpportunitiesDataSource>(
        OpportunitiesDataSourceImpl(rest: Get.find<RestImpl>()));

    // Repository
    Get.put<IOpportunitiesRepository>(OpportunitiesRepositoryImpl(
        iOpportunitiesDataSource: Get.find<IOpportunitiesDataSource>()));

    // Use case
    Get.put<OpportunitiesUseCase>(OpportunitiesUseCase(
        iOpportunitiesRepository: Get.find<IOpportunitiesRepository>()));

    // Controller\
    Get.put<InterestedClientsController>(InterestedClientsController(
        opportunitiesUseCase: Get.find<OpportunitiesUseCase>()));
  }
}
