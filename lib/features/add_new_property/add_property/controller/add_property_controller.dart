import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/provider/add_property_provider.dart';

class AddPropertyController extends GetxController {
  AddPropertyProvider addPropertyProvider = AddPropertyProvider();
  TextEditingController propertyController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController zipCodeController = TextEditingController();
  TextEditingController permitNumberController = TextEditingController();
  TextEditingController lotNumberController = TextEditingController();
  TextEditingController blockNumberController = TextEditingController();

  Rx<FocusNode> propertyFocusNode = FocusNode().obs;
  Rx<FocusNode> streetFocusNode = FocusNode().obs;
  Rx<FocusNode> cityFocusNode = FocusNode().obs;
  Rx<FocusNode> stateFocusNode = FocusNode().obs;
  Rx<FocusNode> zipCodeFocusNode = FocusNode().obs;
  Rx<FocusNode> permitNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> lotNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> blockNumberFocusNode = FocusNode().obs;

  RxList<DropdownModel> beddingMaterialList = <DropdownModel>[].obs;
  var selectedBaseMaterialDropDown = DropdownModel().obs;
  RxBool isShowLoader = false.obs;

  RxBool propertyNameError = false.obs;
  RxBool streetError = false.obs;
  RxBool cityError = false.obs;
  RxBool stateError = false.obs;
  RxBool zipCodeError = false.obs;
  RxBool permitNumberError = false.obs;
  RxBool lotNumberError = false.obs;
  RxBool blockNumberError = false.obs;
  RxBool countyError = false.obs;

  RxString propertyNameErrorMessage = "".obs;
  RxString streetErrorMessage = "".obs;
  RxString cityErrorMessage = "".obs;
  RxString stateErrorMessage = "".obs;
  RxString zipCodeErrorMessage = "".obs;
  RxString permitNumberErrorMessage = "".obs;
  RxString lotNumberErrorMessage = "".obs;
  RxString blockNumberErrorMessage = "".obs;
  RxString countyErrorMessage = "".obs;

  addFocusListeners() {
    propertyFocusNode.value.addListener(() {
      propertyFocusNode.refresh();
    });
    streetFocusNode.value.addListener(() {
      streetFocusNode.refresh();
    });
    cityFocusNode.value.addListener(() {
      cityFocusNode.refresh();
    });

    stateFocusNode.value.addListener(() {
      stateFocusNode.refresh();
    });

    zipCodeFocusNode.value.addListener(() {
      zipCodeFocusNode.refresh();
    });
    permitNumberFocusNode.value.addListener(() {
      permitNumberFocusNode.refresh();
    });

    lotNumberFocusNode.value.addListener(() {
      lotNumberFocusNode.refresh();
    });
    blockNumberFocusNode.value.addListener(() {
      blockNumberFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    propertyFocusNode.value.removeListener(() {});
    streetFocusNode.value.removeListener(() {});
    cityFocusNode.value.removeListener(() {});
    stateFocusNode.value.removeListener(() {});
    zipCodeFocusNode.value.removeListener(() {});
    permitNumberFocusNode.value.removeListener(() {});
    lotNumberFocusNode.value.removeListener(() {});
    blockNumberFocusNode.value.removeListener(() {});
  }

  @override
  void onInit() {
    addFocusListeners();
    initBaseMaterialList();
    super.onInit();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  onSelectBaseMaterialDropdown({required DropdownModel value}) {
    selectedBaseMaterialDropDown.value = value;
  }

  initBaseMaterialList() {
    beddingMaterialList.value = [
      DropdownModel(name: "one", id: "1"),
      DropdownModel(name: "two", id: "2"),
      DropdownModel(name: "three", id: "3"),
    ];
  }

  onPressAddPropertyButton() {
    validate(
        perpertyName: propertyController.text,
        street: streetController.text,
        city: cityController.text,
        state: stateController.text,
        zipCode: zipCodeController.text,
        permitNumber: permitNumberController.text,
        lotNumber: lotNumberController.text,
        blockNumber: blockNumberController.text);
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  getAddProperty() async {
    setShowLoader(value: true);

    var body = json.encode({
      "assigned_user_id": "",
      "property_name": propertyController.text,
      "street": streetController.text,
      "city": cityController.text,
      "zip_code": zipCodeController.text,
      "lot_number": lotNumberController.text,
      "block_number": blockNumberController.text,
      "permit_number": permitNumberController.text,
      "state": stateController.text,
      "county_id": "6243ed27139b3b6b45b4a6f2",
      "acrhitecturel_drawing": "6243ed27139b3b6b45b4a6f2"
    });

    await addPropertyProvider.addProperty(body: body);

    // try {
    //   SignUpResponseModel response =
    //       await addPropertyProvider.addProperty(body: body) ??
    //           SignUpResponseModel();
    //   setShowLoader(value: false);
    //   if (response.success == true &&
    //       (response.status == 201 || response.status == 200)) {
    //     signUpResponse.value = response.data ?? SignUpResponseData();
    //     var token = (response.data?.token ?? "").replaceFirst("Bearer ", "");
    //     if (token != "") Prefs.write(Prefs.token, token);
    //     Get.toNamed(Routes.otpVerifyScreen, arguments: {
    //       GetArgumentConstants.otp: signUpResponse.value.otp,
    //       GetArgumentConstants.phoneNumber:
    //           "+$selectedCountryCode ${phoneNumberController.text}",
    //       GetArgumentConstants.from: Routes.signupScreen
    //     });
    //     snackbar(response.message ?? "");
    //   } else {
    //     setShowLoader(value: false);
    //     apiErrorDialog(
    //       message: response.message ?? AppStrings.somethingWentWrong,
    //       okButtonPressed: () {
    //         Get.back();
    //       },
    //     );
    //   }
    // } catch (e) {
    //   setShowLoader(value: false);
    // }
  }

  void validate({
    required String perpertyName,
    required String street,
    required String city,
    required String state,
    required String zipCode,
    required String permitNumber,
    required String lotNumber,
    required String blockNumber,
  }) async {
    if (perpertyName.isEmpty &&
        street.isEmpty &&
        city.isEmpty &&
        state.isEmpty &&
        zipCode.isEmpty &&
        permitNumber.isEmpty &&
        lotNumber.isEmpty &&
        blockNumber.isEmpty) {
      propertyNameError.value = true;
      streetError.value = true;
      cityError.value = true;
      stateError.value = true;
      zipCodeError.value = true;
      permitNumberError.value = true;
      lotNumberError.value = true;
      blockNumberError.value = true;
    } else if (perpertyName.isEmpty) {
      propertyNameError.value = true;
      propertyNameErrorMessage.value = ErrorMessages.propertyEmty;
    } else if (street.isEmpty) {
      streetError.value = true;
      streetErrorMessage.value = ErrorMessages.streetEmty;
    } else if (city.isEmpty) {
      cityError.value = true;
      cityErrorMessage.value = ErrorMessages.cityEmty;
    } else if (zipCode.isEmpty) {
      zipCodeError.value = true;
      zipCodeErrorMessage.value = ErrorMessages.zipCodeEmty;
    } else if (permitNumber.isEmpty) {
      permitNumberError.value = true;
      permitNumberErrorMessage.value = ErrorMessages.permitEmty;
    } else if (lotNumber.isEmpty) {
      lotNumberError.value = true;
      lotNumberErrorMessage.value = ErrorMessages.lotEmty;
    } else if (blockNumber.isEmpty) {
      blockNumberError.value = true;
      blockNumberErrorMessage.value = ErrorMessages.blockEmty;
    } else {
      propertyNameError.value = false;
      streetError.value = false;
      cityError.value = false;
      stateError.value = false;
      zipCodeError.value = false;
      permitNumberError.value = false;
      lotNumberError.value = false;
      blockNumberError.value = false;

      getAddProperty();
    }
  }

  void onChangedPropertyNameTextField({required String value}) {
    if (value.length >= 2) {
      propertyNameError.value = false;
    }
  }

  void onChangedStreetTextField({required String value}) {
    if (value.length >= 2) {
      streetError.value = false;
    }
  }

  void onChangedCityTextField({required String value}) {
    if (value.length >= 2) {
      cityError.value = false;
    }
  }

  void onChangedStateTextField({required String value}) {
    if (value.length >= 2) {
      stateError.value = false;
    }
  }

  void onChangedZipCodeTextField({required String value}) {
    if (value.length >= 2) {
      streetError.value = false;
    }
  }

  void onChangedPermitNumberTextField({required String value}) {
    if (value.length >= 2) {
      permitNumberError.value = false;
    }
  }

  void onChangedLotNumberTextField({required String value}) {
    if (value.length >= 2) {
      lotNumberError.value = false;
    }
  }

  void onChangedBlocTextField({required String value}) {
    if (value.length >= 2) {
      blockNumberError.value = false;
    }
  }
}
