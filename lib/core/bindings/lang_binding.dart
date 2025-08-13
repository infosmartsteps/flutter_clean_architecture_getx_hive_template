import 'package:get/get.dart';

import '../controllers/lang_controller.dart';

//lib/core/bindings/lang_binding.dart
class LangBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LanguageController>(
          () => LanguageController(),
      fenix: true,
    );
  }
}
