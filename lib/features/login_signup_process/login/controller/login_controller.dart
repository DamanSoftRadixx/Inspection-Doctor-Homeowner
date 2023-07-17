import 'dart:convert';
import 'dart:developer';

import 'package:device_uuid/device_uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/validations/validations.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/social_login/social_login.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/jwt_decoder.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/token_decode_response_model.dart';
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
    // String? deviceId = await DeviceUuid().getUUID();;
    setShowLoader(value: true);
    String deviceToken =
        await Prefs.read(GetArgumentConstants.deviceToken) ?? "";
    String? deviceId = await DeviceUuid().getUUID();

    var body = json.encode({
      "email": emailController.text.trim(),
      "password": passwordController.text.trim(),
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
              message: response.message ?? AppStrings.somethingWentWrong,
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

  checkProfileStatus({required LoginResponseModel response}){
    var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
    if(token != "") {
      Prefs.write(Prefs.token, token);
      LoginTokenModel loginTokenModel = getJsonFromJWTToken(token: token);
      var isOtpVerified = loginTokenModel.data?.isOtpVerified ?? 0;
      if(isOtpVerified == 1){
        Get.toNamed(Routes.dashboard);
      }else{
        Get.toNamed(Routes.otpVerifyScreen,arguments: {
          GetArgumentConstants.otp: loginTokenModel.data?.otp ?? "",
          GetArgumentConstants.email: loginTokenModel.data?.email ?? "",
          GetArgumentConstants.from: Routes.loginScreen
        });
      }
      snackbar(response.message ?? "");
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
              message: response.message ?? AppStrings.somethingWentWrong,
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
              message: response.message ?? AppStrings.somethingWentWrong,
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



}
