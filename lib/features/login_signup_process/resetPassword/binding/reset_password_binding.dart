import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/controller/reset_password_controller.dart';

class ResetPasswordBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ResetPasswordController>(() => ResetPasswordController());
  }
}
