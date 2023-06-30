import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/controller/forget_password_controller.dart';

class ForgetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetPasswordController>(() => ForgetPasswordController());
  }
}
