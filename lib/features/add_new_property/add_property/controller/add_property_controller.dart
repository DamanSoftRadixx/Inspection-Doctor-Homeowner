import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPropertyController extends GetxController {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();

  Rx<FocusNode> firstNameFocusNode = FocusNode().obs;
  Rx<FocusNode> lastNameFocusNode = FocusNode().obs;
  Rx<FocusNode> emailFocusNode = FocusNode().obs;
  Rx<FocusNode> nameFocusNode = FocusNode().obs;
  Rx<FocusNode> phoneNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> passwordFocusNode = FocusNode().obs;
  Rx<FocusNode> confirmPasswordFocusNode = FocusNode().obs;
  Rx<FocusNode> streetFocusNode = FocusNode().obs;
  Rx<FocusNode> cityFocusNode = FocusNode().obs;
  Rx<FocusNode> stateFocusNode = FocusNode().obs;
  Rx<FocusNode> zipCodeFocusNode = FocusNode().obs;

  RxString selectedCountryCode = "1".obs;

  RxBool isHidePassword = true.obs;
  RxBool isHideConfirmPassword = true.obs;

  addFocusListeners() {
    firstNameFocusNode.value.addListener(() {
      firstNameFocusNode.refresh();
    });
    lastNameFocusNode.value.addListener(() {
      lastNameFocusNode.refresh();
    });
    emailFocusNode.value.addListener(() {
      emailFocusNode.refresh();
    });
    nameFocusNode.value.addListener(() {
      nameFocusNode.refresh();
    });
    phoneNumberFocusNode.value.addListener(() {
      phoneNumberFocusNode.refresh();
    });
    passwordFocusNode.value.addListener(() {
      passwordFocusNode.refresh();
    });
    confirmPasswordFocusNode.value.addListener(() {
      confirmPasswordFocusNode.refresh();
    });
    cityFocusNode.value.addListener(() {
      cityFocusNode.refresh();
    });
    streetFocusNode.value.addListener(() {
      streetFocusNode.refresh();
    });
    zipCodeFocusNode.value.addListener(() {
      zipCodeFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    firstNameFocusNode.value.removeListener(() {});
    lastNameFocusNode.value.removeListener(() {});
    emailFocusNode.value.removeListener(() {});
    nameFocusNode.value.removeListener(() {});
    phoneNumberFocusNode.value.removeListener(() {});
    passwordFocusNode.value.removeListener(() {});
    confirmPasswordFocusNode.value.removeListener(() {});
    streetFocusNode.value.removeListener(() {});
    cityFocusNode.value.removeListener(() {});
    stateFocusNode.value.removeListener(() {});
    lastNameFocusNode.value.removeListener(() {});
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
}
