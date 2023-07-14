import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/model/network/forgot_password_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/provider/forgot_password_provider.dart';

class ForgetPasswordController extends GetxController {
  ForgotPasswordProvider forgotPasswordProvider = ForgotPasswordProvider();

  var emailFocusNode = FocusNode().obs;
  TextEditingController emailController = TextEditingController();

  RxBool emailError = false.obs;
  RxString emailErrorMessage = "".obs;
  RxBool isShowLoader = false.obs;

  addFocusListeners() {
    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    emailFocusNode.value.removeListener(() {});
  }

  @override
  void onInit() {
    addFocusListeners();
    super.onInit();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  void validate({
    required String email,
  }) async {
    if (email.isEmpty) {
      emailError.value = true;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
    } else if (!email.isEmail) {
      emailErrorMessage.value = ErrorMessages.emailIsNotValid;
      emailError.value = true;
    } else {
      forgotPasswordApi();
    }
  }

  void onTapSendLinkBotton() {
    dismissKeyboard();
    validate(email: emailController.text);
  }

  void onChangedEmailTextField({required String value}) {
    if (value.isNotEmpty && emailController.text.isEmail) {
      emailError.value = false;
    }
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  forgotPasswordApi() async {
    setShowLoader(value: true);

    var body = json.encode({"email": emailController.text});

    try {
      ForgotPasswordResponseModel response =
          await forgotPasswordProvider.forgotPassword(body: body) ??
              ForgotPasswordResponseModel();

      setShowLoader(value: false);

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {

        var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
        if(token != "") Prefs.write(Prefs.token, token);

        var otpInt = response.data?.otp ?? 0;
        var otpString = otpInt != 0 ? otpInt.toString() : "";

        Get.toNamed(Routes.otpVerifyScreen, arguments: {
          GetArgumentConstants.from: Routes.forgetScreen,
          GetArgumentConstants.otp: otpString,
          GetArgumentConstants.email: emailController.text
        });
        snackbar(response.message ?? "");
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
      isShowLoader.value = false;
    }
  }
}
