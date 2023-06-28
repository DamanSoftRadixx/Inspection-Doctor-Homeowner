import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/signup/presentation/controller/signup_screen_controller.dart';

class SignupScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignupScreenController>(() => SignupScreenController());
  }
}
