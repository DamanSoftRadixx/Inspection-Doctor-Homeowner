import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';

class LoginController extends GetxController {
  RxBool isHidePassword = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;

  RxBool emailError = false.obs;
  RxBool passwordError = false.obs;

  RxString emailErrorMessage = "".obs;
  RxString passwordErrorMessage = "".obs;

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

  void onPressForgotPasswordButton() {
    dismissKeyboard();
    Get.toNamed(Routes.forgetScreen);
  }

  void onTapSignupButton() {
    dismissKeyboard();
    clearTextField();
    Get.toNamed(Routes.signupScreen);
  }

  void onPressLoginButton() {
    dismissKeyboard();

    validate(email: emailController.text, password: passwordController.text);
  }

  void validate({
    required String email,
    required String password,
  }) async {
    print("fjghfjshgjfshg");

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    /* logger("password ${AutoValidate.password(password.toString())}");*/
    if (email.isEmpty && password.isEmpty) {
      print("testtt");

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
    } else if (password.length < 8 || !regExp.hasMatch(password)) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordLength;
    } else {
      emailError.value = false;
      passwordError.value = false;

      Get.toNamed(Routes.dashboard);
    }
  }

  clearTextField() {
    emailController.clear();
    passwordController.clear();
    emailError.value = false;
    passwordError.value = false;
    isHidePassword.value = false;
  }
}
