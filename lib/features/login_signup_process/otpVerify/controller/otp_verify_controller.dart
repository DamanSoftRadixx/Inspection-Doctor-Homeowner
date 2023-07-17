import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/model/network_model/resend_otp_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/model/network_model/verify_otp_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/provider/otp_provider.dart';

class OtpVerifyController extends GetxController {
  OtpVerifyProvider otpVerifyProvider = OtpVerifyProvider();
  RxString verifyCode = "".obs;
  RxBool isOtpError = false.obs;
  var otpError = "".obs;
  RxBool isShowLoader = false.obs;
  var fromScreen = "".obs;

  TextEditingController pinPutController = TextEditingController();

  RxString otp = "".obs;
  RxString phoneNumberOrEmail = "".obs;
  Timer? timer;

  static const timerLength = 120; // in seconds
  RxInt timerCountdown = timerLength.obs;

  @override
  void onInit() {
    getArguments();
    startTimer();
    super.onInit();
  }

  void onTapVerifyButton() {
    dismissKeyboard();
    log("verifyCode ${verifyCode.value.length}");
    if (verifyCode.value.isEmpty && verifyCode.value.length < 4) {
      isOtpError.value = true;
      otpError.value = ErrorMessages.pleaseEnter4DigitOtp.tr;
      isOtpError.refresh();
    } else {
      getOtpVerify();
    }
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      otp.value =
          args[GetArgumentConstants.otp].toString().toStringConversion() ?? "";

      String from =
          args[GetArgumentConstants.from].toString().toStringConversion() ?? "";
      fromScreen.value = from;
      if (from == Routes.forgetScreen || from == Routes.loginScreen) {
        phoneNumberOrEmail.value =
            args[GetArgumentConstants.email].toString().toStringConversion() ??
                "";
      } else {
        phoneNumberOrEmail.value = args[GetArgumentConstants.phoneNumber]
                .toString()
                .toStringConversion() ??
            "";
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
    VerifyOtpResponseModel response =
        await otpVerifyProvider.otpVerification(body: body) ??
            VerifyOtpResponseModel();

    try {
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        isShowLoader.value = false;
        navigateToNext(response: response);
      } else {
        isShowLoader.value = false;
        //  snackbar(response.message ?? "");
      }
    } catch (e) {
      isShowLoader.value = false;
    }
  }

  navigateToNext({required VerifyOtpResponseModel response}) {
    var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
    if (token != "") {
      Prefs.write(Prefs.token, token);
      if (fromScreen.value == Routes.forgetScreen) {
        Get.toNamed(Routes.resetPassword);
      } else if (fromScreen.value == Routes.signupScreen) {
        Get.toNamed(Routes.dashboard);
      } else if (fromScreen.value == Routes.loginScreen) {
        Get.toNamed(Routes.dashboard);
      }
      //  snackbar(response.message ?? "");
    }
  }

  resendOtpApi() async {
    setShowLoader(value: true);

    String token = await Prefs.read(Prefs.token) ?? "";
    var body = json.encode({"token": token});

    try {
      ResendOtpResponseModel response =
          await otpVerifyProvider.resendOtp(body: body) ??
              ResendOtpResponseModel();

      setShowLoader(value: false);

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        var otpInt = response.data?.otp ?? 0;

        otp.value = otpInt == 0 ? "" : otpInt.toString();
        var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
        if (token != "") Prefs.write(Prefs.token, token);
        //  snackbar(response.message ?? "");
        resetTimer();
      } else {
        setShowLoader(value: false);
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      setShowLoader(value: false);
    }
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  resendOtpButtonPressed() {
    if (timerCountdown.value == 0) {
      resendOtpApi();
    }
  }

  resetTimer() {
    timerCountdown.value = timerLength;
    startTimer();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (timerCountdown.value == 0) {
          timer.cancel();
        } else {
          timerCountdown--;
        }
        timerCountdown.refresh();
      },
    );
  }

  String getTimerLabel() {
    return "${formatedTime(timeInSecond: timerCountdown.value)}";
  }

  formatedTime({required int timeInSecond}) {
    int sec = timeInSecond % 60;
    int min = (timeInSecond / 60).floor();
    String minute = min.toString().length <= 1 ? "0$min" : "$min";
    String second = sec.toString().length <= 1 ? "0$sec" : "$sec";
    return "$minute : $second";
  }

  @override
  void onClose() {
    if (timer != null) timer!.cancel();
    super.onClose();
  }
}
