import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_alertdialog.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_snacbar_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/models/navigation_model/signup_to_otp_model.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/models/network_model/login_model.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/models/network_model/otp_verification_model.dart';
import 'package:inspection_doctor_homeowner/features/login/presentation/provider/auth_provider.dart';

class VerifyScreenController extends GetxController {
  TextEditingController verificationController = TextEditingController();
  AuthProvider authProvider = AuthProvider();

  RxBool errorVerify = false.obs;

  FocusNode verificationFocusNode = FocusNode();
  SignupToOtpModel? signupData;
  RxBool isLoading = false.obs;
  Timer? timer;
  var start = 60.obs;

  @override
  void onInit() {
    getArguments();
    startTimer();
    super.onInit();
  }

  getArguments() {
    var arguments = Get.arguments;
    if (arguments != null) {
      signupData = arguments[GetArgumentConstants.signupToOtpModel.tr];
    }
  }

  onChangedVerificationCode({required String value}) {
    if (value.length >= 4) {
      errorVerify.value = false;
      errorVerify.refresh();
    }
  }

  onPressConfirmButton() {
    if (verificationController.text.isEmpty ||
        verificationController.text.length < 4) {
      errorVerify.value = true;
      errorVerify.refresh();
    } else {
      errorVerify.value = false;
      errorVerify.refresh();
      FocusManager.instance.primaryFocus?.unfocus();
      hitOtpVerificationApi();
    }
  }

  hitOtpVerificationApi() async {
    Map<String, dynamic> dataBody = {
      "email": signupData?.email ?? "",
      "verify_token": verificationController.text,
    };

    isLoading.value = true;

    OtpVerificationModel? response =
        await authProvider.mailVerificationRequest(body: dataBody);

    isLoading.value = false;
    bool status = response?.status ?? false;
    String data = response?.data ?? "";
    if (status) {
      if (data != "") {
        loginApi();
      } else {
        showCommonAlertSingleButtonDialog(
            title: AppStrings.error, subHeader: response?.message ?? "");
      }
    }
  }

  goToDashboardScreen() {
    Get.offNamed(Routes.dashboard);
  }

  onPressResendButton() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (start.value == 0) {
      resendOtpApi();
    }
  }

  resendOtpApi() async {
    Map<String, dynamic> dataBody = {
      "email": signupData?.email ?? "",
    };

    isLoading.value = true;

    OtpVerificationModel? response =
        await authProvider.resendOTPRequest(body: dataBody);

    isLoading.value = false;
    bool status = response?.status ?? false;
    String data = response?.data ?? "";
    if (status) {
      start.value = 60;
      startTimer();
      commonSnackBar(
          title: AppStrings.success, message: response?.message ?? "");
    } else {
      showCommonAlertSingleButtonDialog(
          title: AppStrings.error, subHeader: response?.message ?? "");
    }
  }

  Future<void> loginApi() async {
    Map<String, dynamic> dataBody = {
      "email": signupData?.email ?? "",
      "password": signupData?.password ?? "",
    };

    Login? response = await authProvider.loginRequest(body: dataBody);

    isLoading.value = false;

    if ((response?.code ?? 0) == 201) {
      Prefs.storeUserData(
          email: signupData?.email ?? "",
          accessToken: response?.accessToken ?? "");
      goToDashboard();
      commonSnackBar(
          title: AppStrings.success,
          message: AppStrings.youHaveLoginSuccesfully);
    } else {
      print("error");
    }
  }

  goToDashboard() {
    Get.offNamed(Routes.dashboard);
  }

  @override
  void onClose() {
    if (timer != null) timer!.cancel();
    super.onClose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          timer.cancel();
        } else {
          start--;
        }
        start.refresh();
      },
    );
  }
}
