import 'dart:convert';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/network/category_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/request_model/inspection_create_request_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/provider/select_categories_provider.dart';

class SelectedCategoriesController extends GetxController {
  SelectCategoriesProvider selectCategoriesProvider =
      SelectCategoriesProvider();

  var categoriesList = <CategoryListResponseDataModel>[].obs;

  Rx<CategoryListResponseDataModel> selectedCategory =
      CategoryListResponseDataModel().obs;

  var isShowLoader = false.obs;

  @override
  void onInit() {
    getCategoryList();
    super.onInit();
  }

  onPressCategoryItem({required int index}) {
    if (selectedCategory.value.id == categoriesList[index].id) {
      selectedCategory.value = CategoryListResponseDataModel();
    } else {
      selectedCategory.value = categoriesList[index];
    }

    categoriesList.refresh();
  }

  void onPressContinueButton() {
    InspectionCreateRequestModel inspectionCreateRequestModel =
        InspectionCreateRequestModel(
      categoryId: selectedCategory.value.id,
      categoriesName: selectedCategory.value.name,
    );

    Get.toNamed(Routes.inspectionsListScreen, arguments: {
      GetArgumentConstants.inspectionCreateRequestArg:
          inspectionCreateRequestModel,
    });
  }

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  Future<void> getCategoryList() async {
    setShowLoader(value: true);

    var body =
        json.encode({"parent_id": "", "search": "", "start": 0, "length": 0});

    try {
      CategoryListResponseModel response =
          await selectCategoriesProvider.categoryList(body: body) ??
              CategoryListResponseModel();
      setShowLoader(value: false);
      if (response.success == true && (response.status == 200)) {
        response.data?.map((e) => null).toList();
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
