import 'dart:convert';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/InspectionsList/provider/inspections_list_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/network/category_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/request_model/inspection_create_request_model.dart';

class CategoryFormController extends GetxController {
  @override
  void onInit() {
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

  Rx<FocusNode> firstNameFocusNode = FocusNode().obs;
  Rx<FocusNode> lastNameFocusNode = FocusNode().obs;
  Rx<FocusNode> emailFocusNode = FocusNode().obs;
  Rx<FocusNode> phoneNumberFocusNode = FocusNode().obs;

  Rx<TextEditingController> firstNameController = TextEditingController().obs;
  Rx<TextEditingController> lastNameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> phoneNumberController = TextEditingController().obs;

  InspectionsListProvider inspectionsListProvider = InspectionsListProvider();

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

  Rx<DateTime> selectedDate = DateTime(0).obs;

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
  }

  disposeFocusListeners() {
    firstNameFocusNode.value.removeListener(() {});
    lastNameFocusNode.value.removeListener(() {});
    emailFocusNode.value.removeListener(() {});
    phoneNumberFocusNode.value.removeListener(() {});
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
    argData.value.subcategoryId = [selectedCategory.value.id ?? ""];
    argData.value.subCategoriesName = selectedCategory.value.name ?? "";

    Get.toNamed(Routes.inspectionsListScreen, arguments: {
      GetArgumentConstants.inspectionCreateRequestArg: argData.value,
    });
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

  Future<void> getCategoryList() async {
    setShowLoader(value: true);

    var body = json.encode({
      "parent_id": "${argData.value.categoryId}",
      "search": "",
      "start": 0,
      "length": 0
    });

    try {
      CategoryListResponseModel response =
          await inspectionsListProvider.categoryList(body: body) ??
              CategoryListResponseModel();
      setShowLoader(value: false);
      if (response.success == true && (response.status == 200)) {
        categoriesList.value = response.data ?? [];
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
}
