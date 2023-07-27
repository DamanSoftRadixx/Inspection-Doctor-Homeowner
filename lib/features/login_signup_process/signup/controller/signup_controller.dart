import 'dart:convert';
import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:device_uuid/device_uuid.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/location/place.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/validations/validations.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/text/app_text_widget.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/theme/app_color_palette.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/foundation.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/models/network_model/signup_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/provider/signup_provider.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class SignupController extends GetxController {
  SignUpProvider signUpProvider = SignUpProvider();

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> passwordController = TextEditingController().obs;
  Rx<TextEditingController> confirmPasswordController =
      TextEditingController().obs;
  Rx<TextEditingController> streetController = TextEditingController().obs;
  Rx<TextEditingController> cityController = TextEditingController().obs;
  Rx<TextEditingController> stateController = TextEditingController().obs;
  Rx<TextEditingController> zipCodeController = TextEditingController().obs;

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

  Rx<SignUpResponseData> signUpResponse = SignUpResponseData().obs;
  RxBool isShowLoader = false.obs;
  RxBool isEditProfile = false.obs;

  Rx<FFPlace> place = const FFPlace().obs;

  //Language
  RxString languageErrorMessage = "".obs;
  RxBool languageError = false.obs;
  RxList<DropdownModel> languageList = <DropdownModel>[].obs;
  var selectedBaseMaterialDropDown = DropdownModel().obs;
  onSelectBaseMaterialDropdown({required DropdownModel value}) async {
    selectedBaseMaterialDropDown.value = value;
    await Prefs.write(
        Prefs.selectedLangId, selectedBaseMaterialDropDown.value.id);
  }

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
    getArguments();

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

  getArguments() async {
    var args = Get.arguments;
    if (args != null) {
      log("getArguments $args");
      log("getArguments ${GetArgumentConstants.otpFromForget}");

      List<DropdownModel> languageListTemp =
          args[GetArgumentConstants.languageList] ?? List<DropdownModel>;

      if (languageListTemp.isNotEmpty) {
        languageList.value = languageListTemp;
      }
    }
  }

  void validate(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String password,
      required String confirmPassword,
      required bool isLanguageSelected}) async {
    log("testtt ${phone.length < 7}");
    if (firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
        phone.isEmpty &&
        password.isEmpty &&
        confirmPassword.isEmpty &&
        isLanguageSelected == false) {
      firstNameError.value = true;
      lastNameError.value = true;
      emailError.value = true;
      phoneError.value = true;
      passwordError.value = true;
      confirmPasswordError.value = true;
      lastNameError.value = true;

      languageError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty;
      passwordErrorMessage.value = ErrorMessages.passwordIsEmpty;
      confirmPasswordErrorMessage.value = ErrorMessages.confirmPasswordIsEmpty;
      languageErrorMessage.value = ErrorMessages.pleasSelectLanguage;
    } else if (firstName.isEmpty) {
      firstNameError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty;
    } else if (firstName.length < 2) {
      firstNameError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameMatch;
    } else if (lastName.isEmpty) {
      lastNameError.value = true;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty;
    } else if (lastName.length < 2) {
      lastNameError.value = true;
      lastNameErrorMessage.value = ErrorMessages.lastNameMatch;
    } else if (email.isEmpty) {
      emailError.value = true;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty;
    } else if (!email.isEmail) {
      emailErrorMessage.value = ErrorMessages.emailIsNotValid;
      emailError.value = true;
    } else if (phone.isEmpty) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty;
    } else if (phone.length < 7) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneValid;
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
    } else if (isLanguageSelected == false) {
      languageError.value = true;
      languageErrorMessage.value = ErrorMessages.pleasSelectLanguage;
    } else {
      firstNameError.value = false;
      lastNameError.value = false;
      emailError.value = false;
      phoneError.value = false;
      passwordError.value = false;
      confirmPasswordError.value = false;
      languageError.value = false;

      getSignUp();
    }
  }

  void onTapSignButton() {
    dismissKeyboard();
    validate(
        firstName: firstNameController.value.text,
        lastName: lastNameController.value.text,
        email: emailController.value.text,
        phone: phoneNumberController.value.text,
        password: passwordController.value.text,
        confirmPassword: confirmPasswordController.value.text,
        isLanguageSelected: selectedBaseMaterialDropDown.value.id.isNotEmpty);
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
                        color: lightColorPalette.black,
                      ),
                    ),
                  ),
                );
              }
            ]),
      ],
    );
  }

  getSignUp() async {
    setShowLoader(value: true);
    String? deviceId = await DeviceUuid().getUUID();
    String deviceToken =
        await Prefs.read(GetArgumentConstants.deviceToken) ?? "";

    String inspectorRoleId = await Prefs.read(Prefs.homeownerRollId) ?? "";
    // String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";
    var body = json.encode({
      "role_id": inspectorRoleId,
      "register_type": RegisterTypeEnum.email.value,
      "first_name": firstNameController.value.text,
      "last_name": lastNameController.value.text,
      "email": emailController.value.text,
      "phone": phoneNumberController.value.text,
      "password": passwordController.value.text,
      "language_id": selectedBaseMaterialDropDown.value.id,
      "country_code": int.parse(selectedCountryCode.value),
      "state": stateController.value.text,
      "zip_code": zipCodeController.value.text,
      "street": streetController.value.text,
      "city": cityController.value.text,
      "image": "",
      "device_type":
          isIos ? DeviceTypeEnum.iOS.value : DeviceTypeEnum.android.value,
      "device_token": deviceToken,
      "device_id": deviceId
    });

    try {
      SignUpResponseModel response =
          await signUpProvider.signUpUser(body: body) ?? SignUpResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        signUpResponse.value = response.data ?? SignUpResponseData();
        var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
        if (token != "") Prefs.write(Prefs.token, token);
        Get.toNamed(Routes.otpVerifyScreen, arguments: {
          GetArgumentConstants.otp: signUpResponse.value.otp,
          GetArgumentConstants.phoneNumber:
              "+$selectedCountryCode ${phoneNumberController.value.text}",
          GetArgumentConstants.email: emailController.value.text,
          GetArgumentConstants.from: Routes.signupScreen
        });
        //    //  snackbar(response.message ?? "");
      } else {
        setShowLoader(value: false);
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

  void onChangedFirstNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      firstNameController.value.text = firstNameController.value.text.trim();
    }

    if (value.length >= 2) {
      firstNameError.value = false;
    }
  }

  void onChangedLastNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      lastNameController.value.text = lastNameController.value.text.trim();
    }
    if (value.length >= 2) {
      lastNameError.value = false;
    }
  }

  void onChangedEmailTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      firstNameController.value.text = firstNameController.value.text.trim();
    }
    if (value.isNotEmpty && emailController.value.text.isEmail) {
      emailError.value = false;
    }
  }

  void onChangedPhoneTextField({required String value}) {
    if (phoneNumberController.value.text.length > 6) {
      phoneError.value = false;
    }
  }

  void onSelectCountryCode({required Country country}) {
    selectedCountryCode.value = country.phoneCode;
  }

  void onChangedPasswordTextField({required String value}) {
    if (isValidPassword(password: passwordController.value.text)) {
      passwordError.value = false;
    }
  }

  void onPressPasswordEyeIcon() {
    if (isHidePassword.value == false) {
      isHidePassword.value = true;
    } else {
      isHidePassword.value = false;
    }
  }

  void onChangedConfirmPasswordTextField({required String value}) {
    if (value.isNotEmpty &&
        (passwordController.value.text ==
            confirmPasswordController.value.text)) {
      confirmPasswordError.value = false;
    }
  }

  void onPressConfirmPasswordEyeIcon() {
    if (isHideConfirmPassword.value == false) {
      isHideConfirmPassword.value = true;
    } else {
      isHideConfirmPassword.value = false;
    }
  }

  void onTapChooseButton() {
    Get.toNamed(Routes.chooseMap)?.then((value) async {
      if (value != null) {
        PickResult result = value[0][GetArgumentConstants.googleAddressPlace];

        // log("adrAddress ${result.adrAddress}");

        // log("message>>>>>> ${result.formattedAddress}");
        // log("message>>>>> ${result.addressComponents?.first.longName}");
        // log("message ${result.placeId}");

        // for (var i in result.addressComponents ?? []) {
        //   print("Long Name: ${i.longName}   Long Name: ${i.types}");
        // }

        place.value = FFPlace(
          latLng: LatLng(
            result.geometry?.location.lat ?? 0,
            result.geometry?.location.lng ?? 0,
          ),
          name: result.name ?? "",
          address: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('subpremise'))
                  ?.longName ??
              "",
          city: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('locality'))
                  ?.longName ??
              result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('sublocality'))
                  ?.longName ??
              '',
          state: result.addressComponents
                  ?.firstWhereOrNull(
                      (e) => e.types.contains('administrative_area_level_1'))
                  ?.longName ??
              '',
          country: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('country'))
                  ?.longName ??
              '',
          zipCode: result.addressComponents
                  ?.firstWhereOrNull((e) => e.types.contains('postal_code'))
                  ?.longName ??
              '',
        );

        streetController.value.text = place.value.address;
        cityController.value.text = place.value.city;
        stateController.value.text = place.value.state;
        zipCodeController.value.text = place.value.zipCode;
      }
    });
  }

  bool isSignUpButtonEnable() {
    return (firstNameController.value.text.isNotEmpty &&
        lastNameController.value.text.isNotEmpty &&
        emailController.value.text.isNotEmpty &&
        phoneNumberController.value.text.isNotEmpty &&
        passwordController.value.text.isNotEmpty &&
        confirmPasswordController.value.text.isNotEmpty &&
        selectedBaseMaterialDropDown.value.id.isNotEmpty == true);
  }
}
