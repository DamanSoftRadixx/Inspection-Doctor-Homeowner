import 'dart:convert';
import 'dart:developer';

import 'package:device_uuid/device_uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/chage_language.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/validations/validations.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/social_login/social_login.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:inspection_doctor_homeowner/core/utils/image_resources.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/jwt_decoder.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/token_decode_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/models/network_model/login_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/models/network_model/select_language_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/login/provider/login_provider.dart';

class LoginController extends GetxController {
  LoginProvider loginProvider = LoginProvider();

  RxBool isHidePassword = true.obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;

  var emailFocusNode = FocusNode().obs;
  var passwordFocusNode = FocusNode().obs;

  RxBool emailError = false.obs;
  RxBool passwordError = false.obs;

  RxString emailErrorMessage = "".obs;
  RxString passwordErrorMessage = "".obs;

  RxBool isShowLoader = false.obs;
  SocialLogin socialLogin = SocialLogin();

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

  //Language
  RxString languageErrorMessage = "".obs;
  RxBool languageError = false.obs;
  RxList<DropdownModel> languageList = <DropdownModel>[].obs;
  var selectedBaseMaterialDropDown = DropdownModel().obs;
  onSelectBaseMaterialDropdown({required DropdownModel value}) async {
    selectedBaseMaterialDropDown.value = value;
    await Prefs.write(
        Prefs.selectedLangId, selectedBaseMaterialDropDown.value.id);

    changeLanguage();
  }

  setLangunage() async {
    var temp = await Prefs.read(Prefs.selectedLangId);
    int index = languageList.indexWhere((element) => element.id == temp);
    selectedBaseMaterialDropDown.value = languageList[index];
  }

  @override
  void onInit() {
    getLanguage();
    setLangunage();
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
    validate(
        email: emailController.value.text,
        password: passwordController.value.text);
  }

  String? getFirstName(User user) {
    String result = "";
    if (user.displayName?.contains(" ") == true) {
      result = user.displayName?.split(" ").first ?? "";
    }
    return result;
  }

  String? getLastName(User user) {
    String result = "";
    if (user.displayName?.contains(" ") == true) {
      result = user.displayName?.split(" ")[1] ?? "";
    }
    return result;
  }

  void validate({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty && password.isEmpty) {
      emailError.value = true;
      passwordError.value = true;

      emailErrorMessage.value = ErrorMessages.emailIsEmpty.tr;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty.tr;
    } else if (email.isEmpty) {
      emailError.value = true;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty.tr;
    } else if (!email.isEmail) {
      emailErrorMessage.value = ErrorMessages.emailIsNotValid.tr;
      emailError.value = true;
    } else if (password.isEmpty) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty.tr;
    } else if (password.length < 8 || !isValidPassword(password: password)) {
      passwordError.value = true;
      passwordErrorMessage.value = ErrorMessages.passwordLength.tr;
    } else {
      emailError.value = false;
      passwordError.value = false;
      hitLoginApi();
    }
  }

  clearTextField() {
    emailController.value.clear();
    passwordController.value.clear();
    emailError.value = false;
    passwordError.value = false;
    isHidePassword.value = false;
  }

  void onTapSignupButton() {
    dismissKeyboard();
    clearTextField();
    Get.toNamed(Routes.signupScreen,
            arguments: {GetArgumentConstants.languageList: languageList.value})
        ?.then((value) => setLangunage());
  }

  hitLoginApi() async {
    // String? deviceId = await DeviceUuid().getUUID();;
    setShowLoader(value: true);
    String deviceToken =
        await Prefs.read(GetArgumentConstants.deviceToken) ?? "";
    String? deviceId = await DeviceUuid().getUUID();

    var body = json.encode({
      "email": emailController.value.text.trim(),
      "password": passwordController.value.text.trim(),
      "device_type":
          isIos ? DeviceTypeEnum.iOS.value : DeviceTypeEnum.android.value,
      "device_token": deviceToken,
      "device_id": deviceId
    });

    try {
      LoginResponseModel response =
          await loginProvider.login(body: body) ?? LoginResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        checkProfileStatus(response: response);
      } else {
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      setShowLoader(value: false);
    }
  }

  void onChangedEmailTextField({required String value}) {
    if (value.isNotEmpty && emailController.value.text.isEmail) {
      emailError.value = false;
    }

    emailController.refresh();
  }

  void onChangedPasswordTextField({required String value}) {
    if (value.isNotEmpty) {
      if (isValidPassword(password: passwordController.value.text)) {
        passwordError.value = false;
      }
    }
    passwordController.refresh();
  }

  void onPressPasswordEyeIcon() {
    if (isHidePassword.value == false) {
      isHidePassword.value = true;
    } else {
      isHidePassword.value = false;
    }
  }

  void signInWithGoogle() async {
    setShowLoader(value: true);

    try {
      User? user = await socialLogin.signInWithGoogle();

      if (user != null) {
        if (socialLogin.name!.split(" ").length > 1) {
          socialLogin.lastName = socialLogin.name
              ?.substring(socialLogin.name!.lastIndexOf(" ") + 1);
          socialLogin.firstName = socialLogin.name
              ?.substring(0, socialLogin.name?.lastIndexOf(' '));
        } else {
          socialLogin.firstName = socialLogin.name;
        }
        socialLogin.firstName = socialLogin.firstName.toString();
        socialLogin.lastName = socialLogin.lastName.toString();
        String? email = user.email;

        String deviceToken =
            await Prefs.read(GetArgumentConstants.deviceToken) ?? "";
        String? deviceId = await DeviceUuid().getUUID();

        String inspectorRoleId = await Prefs.read(Prefs.homeownerRollId) ?? "";

        var body = json.encode({
          "role_id": inspectorRoleId,
          "register_type": "Email",
          "first_name": socialLogin.firstName,
          "last_name": socialLogin.lastName,
          "email": email,
          "social_key": socialLogin.social_id,
          "device_type":
              isIos ? DeviceTypeEnum.iOS.value : DeviceTypeEnum.android.value,
          "device_token": deviceToken,
          "device_id": deviceId
        });

        log("body $body");

        try {
          LoginResponseModel response =
              await loginProvider.sociaLogin(body: body) ??
                  LoginResponseModel();
          setShowLoader(value: false);
          if (response.success == true &&
              (response.status == 201 || response.status == 200)) {
            checkProfileStatus(response: response);
          } else {
            apiErrorDialog(
              message: response.message ?? AppStrings.somethingWentWrong.tr,
              okButtonPressed: () {
                Get.back();
              },
            );
          }
        } catch (e) {
          setShowLoader(value: false);
        }
      } else {
        setShowLoader(value: false);
      }
    } catch (e) {
      setShowLoader(value: false);
    }
  }

  checkProfileStatus({required LoginResponseModel response}) {
    var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
    if (token != "") {
      Prefs.write(Prefs.token, token);
      TokenResponseModel loginTokenModel = getJsonFromJWTToken(token: token);
      var isOtpVerified = loginTokenModel.data?.isOtpVerified ?? 0;
      if (isOtpVerified == 1) {
        Get.toNamed(Routes.dashboard);
      } else {
        Get.toNamed(Routes.otpVerifyScreen, arguments: {
          GetArgumentConstants.otp: loginTokenModel.data?.otp ?? "",
          GetArgumentConstants.email: loginTokenModel.data?.email ?? "",
          GetArgumentConstants.from: Routes.loginScreen
        });
      }
      //  snackbar(response.message ?? "");
    }
  }

  void signInWithApple() async {
    setShowLoader(value: true);
    try {
      User? user = await socialLogin.signInWithAple();
      if (user != null) {
        print("firstName${user.displayName}");
        print("email${user.email}");
        print("social_id${socialLogin.appleIdCredential?.userIdentifier}");
        // getSocialLogin(
        //     firstName: loginAuthProvider.appleIdCredential?.givenName ?? "",
        //     lastName: loginAuthProvider.appleIdCredential?.familyName ?? "",
        //     socialType: "3",
        //     deviceToken: deviceToken.toString(),
        //     device_type: "2",
        //     social_id:
        //     loginAuthProvider.appleIdCredential?.userIdentifier.toString(),
        //     email: loginAuthProvider.appleIdCredential?.email ?? "");

        String deviceToken =
            await Prefs.read(GetArgumentConstants.deviceToken) ?? "";
        String? deviceId = await DeviceUuid().getUUID();

        String inspectorRoleId = await Prefs.read(Prefs.homeownerRollId) ?? "";

        var body = json.encode({
          "role_id": inspectorRoleId,
          "register_type": "Email",
          "first_name": getFirstName(user),
          "last_name": getLastName(user),
          "email": user.email,
          "social_key": socialLogin.appleIdCredential?.userIdentifier,
          "device_type":
              isIos ? DeviceTypeEnum.iOS.value : DeviceTypeEnum.android.value,
          "device_token": deviceToken,
          "device_id": deviceId
        });

        log("body $body");

        try {
          LoginResponseModel response =
              await loginProvider.sociaLogin(body: body) ??
                  LoginResponseModel();
          setShowLoader(value: false);
          if (response.success == true &&
              (response.status == 201 || response.status == 200)) {
            checkProfileStatus(response: response);
          } else {
            apiErrorDialog(
              message: response.message ?? AppStrings.somethingWentWrong.tr,
              okButtonPressed: () {
                Get.back();
              },
            );
          }
        } catch (e) {
          setShowLoader(value: false);
        }
      } else {
        setShowLoader(value: false);
      }
    } catch (e) {
      setShowLoader(value: false);
    }
  }

  void signInWithFb() async {
    setShowLoader(value: true);

    try {
      User? user = await socialLogin.signInWithFb();
      print("facebook response : ${user.toString()}");
      if (user != null) {
        // getSocialLogin(
        //     firstName: loginAuthProvider.profile?.firstName ?? '',
        //     lastName: loginAuthProvider.profile?.lastName ?? "",
        //     socialType: "2",
        //     deviceToken: deviceToken.toString(),
        //     device_type: "2",
        //     social_id: user.uid,
        //     email: loginAuthProvider.fbEmail ?? '');

        String deviceToken =
            await Prefs.read(GetArgumentConstants.deviceToken) ?? "";
        // String? deviceId = await DeviceUuid().getUUID();;

        String? deviceId = await DeviceUuid().getUUID();

        String inspectorRoleId = await Prefs.read(Prefs.homeownerRollId) ?? "";

        var body = json.encode({
          "role_id": inspectorRoleId,
          "register_type": "Email",
          "first_name": getFirstName(user),
          "last_name": getLastName(user),
          "email": user.email,
          "social_key": socialLogin.appleIdCredential?.userIdentifier,
          "device_type":
              isIos ? DeviceTypeEnum.iOS.value : DeviceTypeEnum.android.value,
          "device_token": deviceToken,
          "device_id": deviceId
        });

        log("body $body");

        try {
          LoginResponseModel response =
              await loginProvider.sociaLogin(body: body) ??
                  LoginResponseModel();
          setShowLoader(value: false);
          if (response.success == true &&
              (response.status == 201 || response.status == 200)) {
            checkProfileStatus(response: response);
          } else {
            apiErrorDialog(
              message: response.message ?? AppStrings.somethingWentWrong.tr,
              okButtonPressed: () {
                Get.back();
              },
            );
          }
        } catch (e) {
          setShowLoader(value: false);
        }
      } else {
        setShowLoader(value: false);
      }
    } catch (e) {
      setShowLoader(value: false);
    }
  }

  getLanguage() async {
    isShowLoader.value = true;
    try {
      GetLangaugeResponseModel response =
          await loginProvider.getLanguages() ?? GetLangaugeResponseModel();
      languageList.clear();
      isShowLoader.value = false;

      if (response.success == true && response.data?.languages != []) {
        response.data?.languages
            ?.map((e) => languageList.add(DropdownModel(
                  id: e.id ?? "",
                  name: e.name ?? "",
                  icon: e.name == "English"
                      ? ImageResource.flagUSA
                      : e.name == "Spanish"
                          ? ImageResource.flagSpain
                          : "",
                )))
            .toList();
        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";

        if (selectedLangId != "") {
          int index = languageList
              .indexWhere((element) => element.id == selectedLangId);
          selectedBaseMaterialDropDown.value = languageList[index];
        }
      } else {
        setShowLoader(value: false);
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      isShowLoader.value = false;
      isShowLoader.refresh();
    }
  }
}
