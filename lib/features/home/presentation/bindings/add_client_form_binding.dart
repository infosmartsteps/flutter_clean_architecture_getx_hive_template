import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/usecases/lookups_usecases.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/add_client_form_controller.dart';

import '../../../../core/network/rest_impl.dart';
import '../../data/datasources/i_lookups_remote_data_source.dart';
import '../../data/datasources/lookups_remote_data_source_impl.dart';
import '../../data/repositories/lookups_repositories_impl.dart';
import '../../domain/repositories/i_lookups_repositories.dart';
import '../controllers/home_controller.dart';

class AddClientFormBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.put<ILookupsRemoteDataSource>(
        LookupsRemoteDataSourceImpl(rest: Get.find<RestImpl>()));

    // Repository
    Get.put<ILookupsRepositories>(LookupsRepositoriesImpl(
        lookupsRemoteDataSource: Get.find<ILookupsRemoteDataSource>()));

    // Use case
    Get.put<LookUpsUseCases>(
        LookUpsUseCases(lookupsRepositories: Get.find<ILookupsRepositories>()));

    // Controller\
    Get.put<AddClientFormController>(
        AddClientFormController(lookUpsUseCases: Get.find<LookUpsUseCases>()));
  }
}
