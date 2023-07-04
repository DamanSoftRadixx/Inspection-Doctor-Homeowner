import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';

class LoginController extends GetxController {
  RxBool isHidePassword = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;

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

  void onPressLoginButton() {
    dismissKeyboard();
    Get.toNamed(Routes.dashboard);
  }
}
