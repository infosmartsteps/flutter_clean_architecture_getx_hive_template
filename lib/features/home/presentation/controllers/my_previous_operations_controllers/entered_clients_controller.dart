import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ksa_real_estates/features/home/domain/parameters/filter_parameters.dart';
import '../../../domain/entities/client_entity.dart';
import '../../../domain/usecases/entered_clients_use_case.dart';
import '../../widgets/snackbars/error_snackbar.dart';

class EnteredClientsController extends GetxController {
  final EnteredClientsUseCase enteredClientsUseCase;

  EnteredClientsController({required this.enteredClientsUseCase});

  Rx<DateTime> from = DateTime(
          DateTime.now().year, DateTime.now().month - 1, DateTime.now().day)
      .obs;
  Rx<DateTime> to = DateTime.now().obs;
  RxString clientName = ''.obs;

  RxBool isLoading = true.obs;
  RxList<ClientEntity> clients = <ClientEntity>[].obs;

  Future<void> getClients() async {
    try {
      isLoading.value = true;
      FilterParameters filterParameters = FilterParameters(
          clientName: clientName.value,
          from: from.toString(),
          to: to.toString());
      final result =
          await enteredClientsUseCase.getEnteredClients(filterParameters);
      result.fold(
        (l) => showErrorSnackBar('Failed to get clients', l),
        (r) => clients.value = r,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> initialize() async {
    await getClients();
  }

  @override
  void onInit() {
    initialize();
    super.onInit();
  }

  void cancel() {
    Get.back();
  }

  void apply(String clientName, String from, String to) {
    this.clientName.value = clientName;
    this.from.value = DateTime.parse(from);
    this.to.value = DateTime.parse(to);

    //logic then get back
    Get.back();
  }
}
