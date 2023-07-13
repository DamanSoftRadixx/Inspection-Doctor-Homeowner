import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/model/select_language_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/models/signup_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/provider/signup_provider.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:platform_device_id_v3/platform_device_id.dart';

class SignupController extends GetxController {
  SignUpProvider signUpProvider = SignUpProvider();

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

  RxBool emailError = false.obs;
  RxBool firstNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool phoneError = false.obs;
  RxBool passwordError = false.obs;
  RxBool confirmPasswordError = false.obs;

  RxString firstNameErrorMessage = "".obs;
  RxString lastNameErrorMessage = "".obs;
  RxString phoneErrorMessage = "".obs;
  RxString emailErrorMessage = "".obs;
  RxString passwordErrorMessage = "".obs;
  RxString confirmPasswordErrorMessage = "".obs;
  RxString selectedCountryCode = "1".obs;

  var selectedProfile = "".obs;

  RxBool isShowLoader = false.obs;

  RxBool isHidePassword = true.obs;
  RxBool isHideConfirmPassword = true.obs;

  Rx<Language> selectedLanguage = Language().obs;

  Rx<SignUpResponseData> signUpResponse = SignUpResponseData().obs;

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

  void validate({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
    required String confirmPassword,
  }) async {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);

    /* logger("password ${AutoValidate.password(password.toString())}");*/
    if (firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
        phone.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty) {
      print("testtt");
      firstNameError.value = true;
      lastNameError.value = true;
      emailError.value = true;
      phoneError.value = true;
      passwordError.value = true;
      confirmPasswordError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
      confirmPasswordErrorMessage.value = ErrorMessages.confirmPasswordIsEmpty;
    } else if (firstName.isEmpty) {
      firstNameError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty;
    } else if (lastName.isEmpty) {
      lastNameError.value = true;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty;
    } else if (email.isEmpty) {
      emailError.value = true;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
    } else if (!email.isEmail) {
      emailErrorMessage.value = ErrorMessages.emailIsNotValid;
      emailError.value = true;
    } else if (phone.isEmpty) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty;
    } else if (phone.length < 8 || phone.length > 15) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneValid;
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
      firstNameError.value = false;
      lastNameError.value = false;
      emailError.value = false;
      phoneError.value = false;
      passwordError.value = false;
      confirmPasswordError.value = false;

      getSignUp();
    }
  }

  void onTapSignButton() {
    dismissKeyboard();
    validate(
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        email: emailController.text,
        phone: phoneNumberController.text,
        password: passwordController.text,
        confirmPassword: confirmPasswordController.text);
  }

  KeyboardActionsConfig buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      keyboardBarColor: Colors.grey[200],
      nextFocus: true,
      actions: [
        KeyboardActionsItem(
            focusNode: phoneNumberFocusNode.value,
            displayArrows: false,
            toolbarButtons: [
              (node) {
                return GestureDetector(
                  onTap: () => passwordFocusNode.value.requestFocus(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppTextWidget(
                      textAlign: TextAlign.start,
                      text: AppStrings.next.tr,
                      style: CustomTextTheme.normalText(
                        color: lightColorPalette.primaryDarkblue,
                      ),
                    ),
                  ),
                );
              }
            ]),
      ],
    );
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      selectedLanguage.value =
          args[GetArgumentConstants.selectedLanguage] ?? "";
    }
  }

  getSignUp() async {
    isShowLoader.value = true;

    String? deviceId = await PlatformDeviceId.getDeviceId;

    String homeownerRollId = await Prefs.read(Prefs.homeownerRollId) ?? "";
    String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";
    var body = json.encode({
      "role_id": homeownerRollId,
      "register_type": "Email",
      "first_name": firstNameController.text,
      "last_name": lastNameController.text,
      "email": emailController.text,
      "phone": phoneNumberController.text,
      "password": passwordController.text,
      "language_id": selectedLangId,
      "country_code": int.parse(selectedCountryCode.value),
      "state": stateController.text,
      "zip_code": zipCodeController.text,
      "street": streetController.text,
      "city": cityController.text,
      "image": "621ca6da33032d8eb3c3b236",
      "device_type": isIos ? DeviceTypeEnum.iOS : DeviceTypeEnum.android.value,
      "device_token": "eydhghjd",
      "device_id": deviceId
    });

    log("bodyData $body");
    SignUpResponseModel response =
        await signUpProvider.signUpUser(body: body) ?? SignUpResponseModel();

    try {
      if (response.success == true && response.status == 201) {
        signUpResponse.value = response.data ?? SignUpResponseData();
        isShowLoader.value = false;
        snackbar(response.message ?? "");
        Prefs.write(Prefs.token, signUpResponse.value.token);
        Future.delayed(const Duration(milliseconds: 2000), () {
          Get.toNamed(Routes.otpVerifyScreen, arguments: {
            GetArgumentConstants.signUpOtp: signUpResponse.value.otp
          });
        });
      } else {
        isShowLoader.value = false;
        snackbar(response.message ?? "");
      }
    } catch (e) {
      isShowLoader.value = false;
    }
  }
}
