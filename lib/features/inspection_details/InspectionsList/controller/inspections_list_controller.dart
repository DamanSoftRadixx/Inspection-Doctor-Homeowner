import 'dart:convert';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/InspectionsList/provider/inspections_list_provider.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/model/network/category_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/model/request_model/inspection_create_request_model.dart';

class InspectionsListController extends GetxController {
  @override
  void onInit() {
    getArguments();
    getCategoryList();

    super.onInit();
  }

  InspectionsListProvider inspectionsListProvider = InspectionsListProvider();
  var categoriesList = <CategoryListResponseDataModel>[].obs;

  Rx<CategoryListResponseDataModel> selectedCategory =
      CategoryListResponseDataModel().obs;

  var isShowLoader = false.obs;
  Rx<InspectionCreateRequestModel> argData = InspectionCreateRequestModel().obs;

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

    Get.toNamed(Routes.categoryFormScreen, arguments: {
      GetArgumentConstants.inspectionCreateRequestArg: argData.value,
    });
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
}
