import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/presentation/controller/signup_screen_controller.dart';

class SignupScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupScreenController>(() => SignupScreenController());
  }
}
