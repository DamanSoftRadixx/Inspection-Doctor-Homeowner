import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/controller/otp_verify_controller.dart';

class OtpVerifyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerifyController>(() => OtpVerifyController());
  }
}
