import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../../core/data/local/storage_helper.dart';
import '../../../auth/domain/entities/login_entity.dart';

class HomeController extends GetxController {
  Rx<LogInEntity> user = LogInEntity().obs;
  Rx<PackageInfo> packageInfo =
      PackageInfo(appName: '', packageName: '', version: '', buildNumber: '')
          .obs;

  getUserData() async {
    user.value = await StorageHelper().getUser();
    update();
  }

  Future<void> getAppInfo() async {
    final PackageInfo packageInfo = await StorageHelper().getAppInfo();
    this.packageInfo.value = packageInfo;
  }

  @override
  void onInit() async {
    await getUserData();
    await getAppInfo();
    super.onInit();
  }
}
