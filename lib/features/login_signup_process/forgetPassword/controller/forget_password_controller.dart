import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';

class ForgetPasswordController extends GetxController {
  var emailFocusNode = FocusNode().obs;
  TextEditingController emailController = TextEditingController();

  RxBool emailError = false.obs;
  RxString emailErrorMessage = "".obs;

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
      Get.toNamed(Routes.resetPassword);
    }
  }

  void onTapSendLinkBotton() {
    dismissKeyboard();
    validate(email: emailController.text);
  }
}
