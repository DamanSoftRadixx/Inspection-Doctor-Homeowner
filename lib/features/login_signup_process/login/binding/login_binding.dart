import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/controller/login_controller.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
  }
}
