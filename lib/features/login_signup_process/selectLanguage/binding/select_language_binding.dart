import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/controller/controller.dart';

class SelectLanguageBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SelectLanguageController>(() => SelectLanguageController());
  }
}
