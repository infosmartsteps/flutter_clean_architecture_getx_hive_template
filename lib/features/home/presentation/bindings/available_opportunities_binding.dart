import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/presentation/controllers/available_opportunities_controller.dart';

import '../../../../core/network/rest_impl.dart';
import '../../data/datasources/clints/clients_data_source_impl.dart';
import '../../data/datasources/clints/i_clients_data_source.dart';
import '../../data/datasources/properties/i_property_data_source.dart';
import '../../data/datasources/properties/property_data_source_impl.dart';
import '../../data/repositories/clients_repository_impl.dart';
import '../../data/repositories/property_repository_impl.dart';
import '../../domain/repositories/i_clients_repository.dart';
import '../../domain/repositories/i_property_repository.dart';
import '../../domain/usecases/clients_use_case.dart';
import '../../domain/usecases/property_use_case.dart';

class AvailableOpportunitiesBinding extends Bindings {
  @override
  void dependencies() {
    // Data source
    Get.put<IPropertyDataSource>(
        PropertyDataSourceImpl(rest: Get.find<RestImpl>()));
    Get.put<IClientsDataSource>(
        ClientsDataSourceImpl(rest: Get.find<RestImpl>()));

    // Repository
    Get.put<IPropertyRepository>(PropertyRepositoryImpl(
        iPropertyDataSource: Get.find<IPropertyDataSource>()));

    Get.put<IClientsRepository>(ClientsRepositoryImpl(
        iClientsDataSource: Get.find<IClientsDataSource>()));

    // Use case
    Get.put<PropertyUseCase>(
        PropertyUseCase(iPropertyRepository: Get.find<IPropertyRepository>()));

    Get.put<ClientsUseCase>(
        ClientsUseCase(iClientsRepository: Get.find<IClientsRepository>()));

    // Controller\
    Get.put<AvailableOpportunitiesController>(AvailableOpportunitiesController(
        propertyUseCase: Get.find<PropertyUseCase>(),
        clientsUseCase: Get.find<ClientsUseCase>()));
  }
}
