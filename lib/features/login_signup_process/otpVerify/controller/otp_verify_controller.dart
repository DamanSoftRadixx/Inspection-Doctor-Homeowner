import 'dart:developer';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

class OtpVerifyController extends GetxController {
  RxString verifyCode = "".obs;
  RxBool isSubmitVisible = false.obs;
  RxBool isNeedResendOTP = false.obs;

  RxBool isOTPFromForget = false.obs;

  @override
  void onInit() {
    getArguments();

    super.onInit();
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      log("getArguments $args");
      log("getArguments ${GetArgumentConstants.otpFromForget}");
      if (GetArgumentConstants.otpFromForget == args) {
        log("getArguments ${GetArgumentConstants.otpFromForget == args}");
        isOTPFromForget.value = true;
      }
    }
  }
}
