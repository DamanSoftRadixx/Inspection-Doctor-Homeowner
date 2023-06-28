import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/controller/forget_password_controller.dart';

class ForgetScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgetScreenController>(() => ForgetScreenController());
  }
}
