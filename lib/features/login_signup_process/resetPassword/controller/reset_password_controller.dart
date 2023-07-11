import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

class ResetPasswordController extends GetxController {
  Rx<FocusNode> passwordFocusNode = FocusNode().obs;
  Rx<FocusNode> confirmPasswordFocusNode = FocusNode().obs;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  RxBool isHidePassword = true.obs;
  RxBool isHideConfirmPassword = true.obs;

  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;

  RxString passwordErrorMessage = "".obs;
  RxString confirmPasswordErrorMessage = "".obs;

  addFocusListeners() {
    passwordFocusNode.value.addListener(() {
      passwordFocusNode.refresh();
    });
    confirmPasswordFocusNode.value.addListener(() {
      confirmPasswordFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    passwordFocusNode.value.removeListener(() {});
    confirmPasswordFocusNode.value.removeListener(() {});
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
    required String password,
    required String confirmPassword,
  }) async {
    print("fjghfjshgjfshg");

    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    /* logger("password ${AutoValidate.password(password.toString())}");*/
    if (password.isEmpty && confirmPassword.isEmpty) {
      passwordError.value = true;
      confirmPasswordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
      confirmPasswordErrorMessage.value = ErrorMessages.confirmPasswordIsEmpty;
    } else if (password.isEmpty) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
    } else if (password.length < 8 || !regExp.hasMatch(password)) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordLength;
    } else if (confirmPassword.isEmpty) {
      confirmPasswordError.value = true;
      confirmPasswordErrorMessage.value = ErrorMessages.confirmPasswordIsEmpty;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = true;
      confirmPasswordErrorMessage.value = ErrorMessages.passwordMatches;
    } else {
      passwordError.value = false;
      confirmPasswordError.value = false;
    }
  }
}
