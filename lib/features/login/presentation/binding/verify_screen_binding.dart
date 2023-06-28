import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/controller/verify_screen_controlller.dart';

class VerifyScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VerifyScreenController>(() => VerifyScreenController());
  }
}
