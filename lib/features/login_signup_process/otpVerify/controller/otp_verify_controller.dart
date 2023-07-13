import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/model/verifiy_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/provider/otp_provider.dart';

class OtpVerifyController extends GetxController {
  OtpVerifyProvider otpVerifyProvider = OtpVerifyProvider();
  RxString verifyCode = "".obs;
  RxBool isOtpError = false.obs;
  RxBool isNeedResendOTP = false.obs;
  RxBool isShowLoader = false.obs;
  RxBool isOTPFromForget = false.obs;

  TextEditingController pinPutController = TextEditingController();

  Rx<OtpVerifyResponseData> otpVerifyResponseData = OtpVerifyResponseData().obs;

  RxString otp = "".obs;

  @override
  void onInit() {
    getArguments();
    super.onInit();
  }

  void onTapVerifyButton() {
    dismissKeyboard();
    log("verifyCode ${verifyCode.value.length}");
    if (verifyCode.value.length == 4) {
      getOtpVerify();
    } else {
      isOtpError.value = true;
    }
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      otp.value = args[GetArgumentConstants.selectedLanguage] ?? "";
      String otpFromForget = args[GetArgumentConstants.otpFromForget] ?? "";

      log("getArguments $args");
      log("getArguments ${GetArgumentConstants.otpFromForget}");
      if (GetArgumentConstants.otpFromForget == otpFromForget) {
        log("getArguments ${GetArgumentConstants.otpFromForget == args}");
        isOTPFromForget.value = true;
      }
    }
  }

  getOtpVerify() async {
    isShowLoader.value = true;

    String token = await Prefs.read(Prefs.token) ?? "";

    log("verifyCode ${verifyCode.value}");
    var body =
        json.encode({"otp": verifyCode.value.toString(), "token": token});

    log("bodyData $body");
    OtpVerifyResponse response =
        await otpVerifyProvider.otpVerification(body: body) ??
            OtpVerifyResponse();

    try {
      if (response.success == true && response.status == 201) {
        otpVerifyResponseData.value = response.data ?? OtpVerifyResponseData();
        isShowLoader.value = false;
        snackbar(response.message ?? "");

        Future.delayed(const Duration(milliseconds: 2000), () {
          isOTPFromForget.value
              ? Get.toNamed(Routes.resetPassword)
              : Get.until((route) =>
                  route.settings.name == Routes.loginScreen ? true : false);
        });
      } else {
        isShowLoader.value = false;
        snackbar(response.message ?? "");
      }
    } catch (e) {
      isShowLoader.value = false;
    }
  }
}
