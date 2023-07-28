import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/validations/validations.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/model/network/reset_password_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/provider/reset_password_provider.dart';

class ResetPasswordController extends GetxController {
  ResetPasswordProvider resetPasswordProvider = ResetPasswordProvider();

  Rx<FocusNode> passwordFocusNode = FocusNode().obs;
  Rx<FocusNode> confirmPasswordFocusNode = FocusNode().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  RxBool isHidePassword = true.obs;
  RxBool isHideConfirmPassword = true.obs;

  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;

  RxString passwordErrorMessage = "".obs;
  RxString confirmPasswordErrorMessage = "".obs;

  RxBool isShowLoader = false.obs;

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
    if (password.isEmpty && confirmPassword.isEmpty) {
      passwordError.value = true;
      confirmPasswordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
      confirmPasswordErrorMessage.value = ErrorMessages.confirmPasswordIsEmpty;
    } else if (password.isEmpty) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
    } else if (password.length < 8 || !isValidPassword(password: password)) {
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
      resetPasswordApi();
    }
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  resetPasswordApi() async {
    setShowLoader(value: true);

    var body = json.encode({"new_password": passwordController.value.text});

    try {
      ResetPasswordResponseModel response =
          await resetPasswordProvider.resetPassword(body: body) ??
              ResetPasswordResponseModel();

      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        snackbar(response.message ?? "");
        Get.until((route) =>
            route.settings.name == Routes.loginScreen ? true : false);
      } else {
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

  void onChangedConfirmPasswordTextField({required String value}) {
    if (value.isNotEmpty &&
        (passwordController.value.text ==
            confirmPasswordController.value.text)) {
      confirmPasswordError.value = false;
    }
    confirmPasswordController.refresh();
  }

  void onPressConfirmPasswordEyeIcon() {
    if (isHideConfirmPassword.value == false) {
      isHideConfirmPassword.value = true;
    } else {
      isHideConfirmPassword.value = false;
    }
  }

  void onPressPasswordEyeIcon() {
    if (isHidePassword.value == false) {
      isHidePassword.value = true;
    } else {
      isHidePassword.value = false;
    }
  }

  void onChangedPasswordTextField({required String value}) {
    if (isValidPassword(password: value)) {
      passwordError.value = false;
    }
    passwordController.refresh();
  }
}
