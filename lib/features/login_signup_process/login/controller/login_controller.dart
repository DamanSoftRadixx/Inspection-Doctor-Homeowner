import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/validations/validations.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/models/network_model/login_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/provider/login_provider.dart';

class LoginController extends GetxController {
  LoginProvider loginProvider = LoginProvider();

  RxBool isHidePassword = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;

  RxBool emailError = false.obs;
  RxBool passwordError = false.obs;

  RxString emailErrorMessage = "".obs;
  RxString passwordErrorMessage = "".obs;

  RxBool isShowLoader = false.obs;

  addFocusListeners() {
    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });
    passwordFocusNode.value.addListener(() {
      passwordFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    emailFocusNode.value.removeListener(() {});
    passwordFocusNode.value.removeListener(() {});
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

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  void onPressForgotPasswordButton() {
    dismissKeyboard();
    clearTextField();
    Get.toNamed(Routes.forgetScreen);
  }

  void onPressLoginButton() {
    dismissKeyboard();
    validate(email: emailController.text, password: passwordController.text);
  }

  void validate({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty && password.isEmpty) {
      emailError.value = true;
      passwordError.value = true;

      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
    } else if (email.isEmpty) {
      emailError.value = true;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
    } else if (!email.isEmail) {
      emailErrorMessage.value = ErrorMessages.emailIsNotValid;
      emailError.value = true;
    } else if (password.isEmpty) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
    } else if (password.length < 8 || !isValidPassword(password: password)) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordLength;
    } else {
      emailError.value = false;
      passwordError.value = false;
      hitLoginApi();
    }
  }

  clearTextField() {
    emailController.clear();
    passwordController.clear();
    emailError.value = false;
    passwordError.value = false;
    isHidePassword.value = false;
  }

  void onTapSignupButton() {
    dismissKeyboard();
    clearTextField();
    Get.toNamed(Routes.signupScreen);
  }


  hitLoginApi() async {
    // String? deviceId = await PlatformDeviceId.getDeviceId;
    setShowLoader(value: true);

    var body = json.encode({
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
      "device_type":
      isIos ? DeviceTypeEnum.iOS.value : DeviceTypeEnum.android.value,
      "device_token": "eydhghjd",
      "device_id": "A4"
    });

    try {
      LoginResponseModel response =
          await loginProvider.login(body: body) ?? LoginResponseModel();
      setShowLoader(value: false);
      if (response.success == true && (response.status == 201 || response.status == 200)) {
        var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
        if(token != "") Prefs.write(Prefs.token, token);
        Get.toNamed(Routes.dashboard);
        snackbar(response.message ?? "");
      } else {
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );       }
    } catch (e) {
      setShowLoader(value: false);
    }
  }

  void onChangedEmailTextField({required String value}) {
    if (value.isNotEmpty && emailController.text.isEmail) {
      emailError.value = false;
    }
  }

  void onChangedPasswordTextField({required String value}) {
    if (value.isNotEmpty) {
      if (isValidPassword(password: passwordController.text)) {
        passwordError.value = false;
      }
    }
  }

  void onPressPasswordEyeIcon() {
    if (isHidePassword.value == false) {
      isHidePassword.value = true;
    } else {
      isHidePassword.value = false;
    }
  }
}
