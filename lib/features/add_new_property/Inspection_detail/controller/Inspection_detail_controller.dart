import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/textfields/app_common_text_form_field.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/categoriesForm/provider/categories_form_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/network/category_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/request_model/inspection_create_request_model.dart';

class InspectionDetailController extends GetxController {
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
    getArguments();

    super.onInit();
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

  getContactDetails() {
    firstNameController.value.text = inspectionDetail.value.firstName ?? "";
    lastNameController.value.text = inspectionDetail.value.lastName ?? "";
    emailController.value.text = inspectionDetail.value.email ?? "";
    phoneNumberController.value.text = inspectionDetail.value.phone ?? "";
    selectedCountryCode.value = inspectionDetail.value.countryCode ?? "";
  }

  RxBool isShowLoader = false.obs;
  Rx<ScheduleInspectionResponseData> inspectionDetail =
      ScheduleInspectionResponseData().obs;
  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      inspectionDetail.value = args[GetArgumentConstants.inspectionDetail] ??
          InspectionCreateRequestModel();
    }
  }

  Rx<String> selectedDate = "".obs;
  RxList<DropdownModel> timeList = <DropdownModel>[].obs;

  var selectTime = DropdownModel().obs;

  onSelectTimeDropdown({required DropdownModel value}) async {
    selectTime.value = value;
  }

  var categoriesList = <CategoryListResponseDataModel>[].obs;

  void onSelectCountryCode({required Country country}) {
    selectedCountryCode.value = country.phoneCode;
  }

  Rx<CategoryListResponseDataModel> selectedCategory =
      CategoryListResponseDataModel().obs;

  Rx<InspectionCreateRequestModel> argData = InspectionCreateRequestModel().obs;
  RxString selectedCountryCode = "1".obs;

  Rx<FocusNode> firstNameFocusNode = FocusNode().obs;
  Rx<FocusNode> lastNameFocusNode = FocusNode().obs;
  Rx<FocusNode> emailFocusNode = FocusNode().obs;
  Rx<FocusNode> phoneNumberFocusNode = FocusNode().obs;
  Rx<FocusNode> descriptionFocusNode = FocusNode().obs;
  RxList<DropdownModel> selectedTime = <DropdownModel>[].obs;
  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;
  Rx<TextEditingController> descriptionController = TextEditingController().obs;

  RxBool emailError = false.obs;
  RxBool firstNameError = false.obs;
  RxBool lastNameError = false.obs;
  RxBool phoneError = false.obs;

  RxString firstNameErrorMessage = "".obs;
  RxString lastNameErrorMessage = "".obs;
  RxString phoneErrorMessage = "".obs;
  RxString emailErrorMessage = "".obs;

  void onChangedFirstNameTextField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      firstNameController.value.text = firstNameController.value.text.trim();
    }

    if (value.length >= 2) {
      firstNameError.value = false;
    }
  }

  void onChangedDescriptionField({required String value}) {
    if (value.length == 1 && value.contains(" ")) {
      descriptionController.value.text =
          descriptionController.value.text.trim();
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
}
