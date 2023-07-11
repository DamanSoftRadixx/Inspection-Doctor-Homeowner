import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';

class OtpVerifyController extends GetxController {
  RxString verifyCode = "".obs;
  RxBool isOtpError = false.obs;

  RxBool isNeedResendOTP = false.obs;

  void onTapVerifyButton() {
    dismissKeyboard();
    if (verifyCode.value.length == 4) {
      Get.until(
          (route) => route.settings.name == Routes.loginScreen ? true : false);
    } else {
      isOtpError.value = true;
    }
  }
}
