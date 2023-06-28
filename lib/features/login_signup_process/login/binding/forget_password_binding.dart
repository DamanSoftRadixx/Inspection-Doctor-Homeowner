import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/controller/forget_password_controller.dart';

class ForgetScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetScreenController>(() => ForgetScreenController());
  }
}
