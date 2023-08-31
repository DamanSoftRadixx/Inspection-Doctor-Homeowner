import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/dismiss_keyboard.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/date_formatter/date_formatter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/time_model.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/jwt_decoder.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/token_decode_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/InspectionsList/provider/inspections_list_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/categoriesForm/provider/categories_form_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/network/category_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/request_model/inspection_create_request_model.dart';

class CategoryFormController extends GetxController {
  CategoryFormProvider categoryFormProvider = CategoryFormProvider();
  @override
  void onInit() {
    getContactDetails();
    timeList.addAll([
      DropdownModel(
          id: "0",
          name: "All day (8am-6pm)",
          startTime: '08:00',
          endTime: "18:00"),
      DropdownModel(
          id: "1",
          name: "Morning (8am-12pm)",
          startTime: '08:00',
          endTime: "12:00"),
      DropdownModel(
          id: "2",
          name: "Afternoon (12pm-3pm)",
          startTime: '12:00',
          endTime: "15:00"),
      DropdownModel(
          id: "3",
          name: "Evening (3pm-6pm)",
          startTime: '15:00',
          endTime: "18:00"),
    ]);
    addFocusListeners();
    getArguments();
    // getCategoryList();

    super.onInit();
  }

  @override
  void onClose() {
    disposeFocusListeners();
    super.onClose();
  }

  RxList<DropdownModel> selectedTime = <DropdownModel>[].obs;
  Rx<FocusNode> firstNameFocusNode = FocusNode().obs;
  Rx<FocusNode> lastNameFocusNode = FocusNode().obs;
  Rx<FocusNode> emailFocusNode = FocusNode().obs;
  Rx<FocusNode> phoneNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> descriptionFocusNode = FocusNode().obs;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;
  InspectionsListProvider inspectionsListProvider = InspectionsListProvider();

  RxList<DropdownModel> timeList = <DropdownModel>[].obs;

  var selectTime = DropdownModel().obs;

  onSelectTimeDropdown({required DropdownModel value}) async {
    selectTime.value = value;
  }

  RxBool emailError = false.obs;
  RxBool firstNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool phoneError = false.obs;

  RxString firstNameErrorMessage = "".obs;
  RxString lastNameErrorMessage = "".obs;
  RxString phoneErrorMessage = "".obs;
  RxString emailErrorMessage = "".obs;

  var categoriesList = <CategoryListResponseDataModel>[].obs;

  Rx<CategoryListResponseDataModel> selectedCategory =
      CategoryListResponseDataModel().obs;

  var isShowLoader = false.obs;
  Rx<InspectionCreateRequestModel> argData = InspectionCreateRequestModel().obs;
  RxString selectedCountryCode = "1".obs;

  void onSelectCountryCode({required Country country}) {
    selectedCountryCode.value = country.phoneCode;
  }

  Rx<String> selectedDate = "".obs;

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

    phoneNumberFocusNode.value.addListener(() {
      phoneNumberFocusNode.refresh();
    });
    descriptionFocusNode.value.addListener(() {
      phoneNumberFocusNode.refresh();
    });
  }

  disposeFocusListeners() {
    firstNameFocusNode.value.removeListener(() {});
    lastNameFocusNode.value.removeListener(() {});
    emailFocusNode.value.removeListener(() {});
    phoneNumberFocusNode.value.removeListener(() {});
    descriptionFocusNode.value.removeListener(() {});
  }
  // Rx<String> categoriesName = "".obs;

  onPressCategoryItem({required int index}) {
    if (selectedCategory.value.id == categoriesList[index].id) {
      selectedCategory.value = CategoryListResponseDataModel();
    } else {
      selectedCategory.value = categoriesList[index];
    }

    categoriesList.refresh();
  }

  void onPressContinueButton() {
    dismissKeyboard();
    validate(
        firstName: firstNameController.value.text,
        lastName: lastNameController.value.text,
        email: emailController.value.text,
        phone: phoneNumberController.value.text,
        date: selectedDate.string,
        isTimeSelected: selectedTime.isNotEmpty);
  }

  void onChangedFirstNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      firstNameController.value.text = firstNameController.value.text.trim();
    }

    if (value.length >= 2) {
      firstNameError.value = false;
    }

    firstNameController.refresh();
  }

  void onChangedDescriptionField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      descriptionController.value.text =
          descriptionController.value.text.trim();
    }
    descriptionController.refresh();
  }

  void onChangedLastNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      lastNameController.value.text = lastNameController.value.text.trim();
    }
    if (value.length >= 2) {
      lastNameError.value = false;
    }
    lastNameController.refresh();
  }

  void onChangedEmailTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      firstNameController.value.text = firstNameController.value.text.trim();
    }
    if (value.isNotEmpty && emailController.value.text.isEmail) {
      emailError.value = false;
    }
    firstNameController.refresh();
  }

  void onChangedPhoneTextField({required String value}) {
    if (phoneNumberController.value.text.length > 6) {
      phoneError.value = false;
    }
    phoneNumberController.refresh();
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      argData.value = args[GetArgumentConstants.inspectionCreateRequestArg] ??
          InspectionCreateRequestModel();
    }
  }

  Future<void> createInspection() async {
    setShowLoader(value: true);

    List<TimeModel> utcDateTimeList = [];

    if (selectedTime.isNotEmpty) {
      //If all days selected
      if (selectedTime.length == 1 && selectedTime.first == timeList.first) {
        selectedTime.clear();
        selectedTime.add(timeList[1]);
        selectedTime.add(timeList[2]);
        selectedTime.add(timeList[3]);

        selectedTime.map((e) {
          if (e == timeList.first) {
            utcDateTimeList.add(TimeModel(
                starttime: getUtcDateString(
                    date: selectedDate.value, time: e.startTime),
                endtime: getUtcDateString(
                    date: selectedDate.value, time: e.endTime)));
          }

          utcDateTimeList.add(TimeModel(
              starttime:
                  getUtcDateString(date: selectedDate.value, time: e.startTime),
              endtime:
                  getUtcDateString(date: selectedDate.value, time: e.endTime)));
        }).toList();
      } else {
        //If all days  not selected
        selectedTime.map((e) {
          if (e == timeList.first) {
            utcDateTimeList.add(TimeModel(
                starttime: getUtcDateString(
                    date: selectedDate.value, time: e.startTime),
                endtime: getUtcDateString(
                    date: selectedDate.value, time: e.endTime)));
          }

          utcDateTimeList.add(TimeModel(
              starttime:
                  getUtcDateString(date: selectedDate.value, time: e.startTime),
              endtime:
                  getUtcDateString(date: selectedDate.value, time: e.endTime)));
        }).toList();
      }
    }

    argData.value.firstName = firstNameController.value.text;
    argData.value.lastName = lastNameController.value.text;
    argData.value.phone = phoneNumberController.value.text;
    argData.value.email = emailController.value.text;
    argData.value.phone = phoneNumberController.value.text;
    argData.value.date = getDateFormattedFromString(
        dateString: selectedDate.value, inputFormat: "yyyy-MM-dd");
    argData.value.countryCode = selectedCountryCode.value;
    argData.value.time = utcDateTimeList;
    argData.value.description = descriptionController.value.text;
    argData.value.homeownerId = tokenResponse.value.data?.id ?? "";

    var body = json.encode(argData.value);

    try {
      CategoryListResponseModel response =
          await categoryFormProvider.createInspection(body: body) ??
              CategoryListResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 200 || response.status == 201)) {
        showCommonAlertSingleButtonDialog(
            title: AppStrings.alert.tr,
            subHeader: response.message ?? "",
            okPressed: () {
              Get.until((route) =>
                  route.settings.name == Routes.propertyDetailScreen
                      ? true
                      : false);
            },
            buttonTitle: AppStrings.ok.tr);
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

  Rx<TokenResponseModel> tokenResponse = TokenResponseModel().obs;
  getContactDetails() {
    var token = Prefs.read(Prefs.token);
    if (token != null && token != "") {
      tokenResponse.value = getJsonFromJWTToken(token: token);

      firstNameController.value.text =
          tokenResponse.value.data?.firstName ?? "";
      lastNameController.value.text = tokenResponse.value.data?.lastName ?? "";
      emailController.value.text = tokenResponse.value.data?.email ?? "";
      phoneNumberController.value.text = tokenResponse.value.data?.phone ?? "";

      if (tokenResponse.value.data?.countryCode != null) {
        selectedCountryCode.value = tokenResponse.value.data?.countryCode ?? "";
      } else {
        selectedCountryCode.value = selectedCountryCode.value;
      }
    }
  }

  bool isScheduleButtonEnable() {
    bool result = false;

    if (selectedDate.value != "" &&
        selectedTime.isNotEmpty &&
        firstNameController.value.text.isNotEmpty &&
        lastNameController.value.text.isNotEmpty &&
        phoneNumberController.value.text.isNotEmpty &&
        emailController.value.text.isNotEmpty) {
      result = true;
    }
    return result;
  }

  void validate(
      {required String firstName,
      required String lastName,
      required String email,
      required String phone,
      required String date,
      required bool isTimeSelected}) async {
    if (firstName.isEmpty &&
        lastName.isEmpty &&
        email.isEmpty &&
        phone.isEmpty) {
      firstNameError.value = true;
      lastNameError.value = true;
      emailError.value = true;
      phoneError.value = true;

      lastNameError.value = true;

      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty.tr;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty.tr;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty.tr;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty.tr;
    } else if (firstName.isEmpty) {
      firstNameError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameIsEmpty.tr;
    } else if (firstName.length < 2) {
      firstNameError.value = true;
      firstNameErrorMessage.value = ErrorMessages.firstNameMatch.tr;
    } else if (lastName.isEmpty) {
      lastNameError.value = true;
      lastNameErrorMessage.value = ErrorMessages.lastNameIsEmpty.tr;
    } else if (lastName.length < 2) {
      lastNameError.value = true;
      lastNameErrorMessage.value = ErrorMessages.lastNameMatch.tr;
    } else if (email.isEmpty) {
      emailError.value = true;
      emailErrorMessage.value = ErrorMessages.emailIsEmpty.tr;
    } else if (!email.isEmail) {
      emailErrorMessage.value = ErrorMessages.emailIsNotValid.tr;
      emailError.value = true;
    } else if (phone.isEmpty) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneIsEmpty.tr;
    } else if (phone.length < 7) {
      phoneError.value = true;
      phoneErrorMessage.value = ErrorMessages.phoneValid.tr;
    } else {
      firstNameError.value = false;
      lastNameError.value = false;
      emailError.value = false;
      phoneError.value = false;

      createInspection();
    }
  }
}
