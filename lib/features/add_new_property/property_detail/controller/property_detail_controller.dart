import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/delete_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/provider/property_detail_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/request_model/inspection_create_request_model.dart';

class PropertyDetailController extends GetxController {
  PropertyDetailProvider propertyDetailProvider = PropertyDetailProvider();
  Rx<PropertyListData> propertyDetail = PropertyListData().obs;

  RxList<ScheduleInspectionListResponseDataModel> scheduleInspectionList =
      <ScheduleInspectionListResponseDataModel>[].obs;
  onPressAddPropertyButton() {
    InspectionCreateRequestModel inspectionCreateRequestModel =
        InspectionCreateRequestModel(
      propertyId: propertyDetail.value.id,
    );

    Get.toNamed(Routes.selectCategoriesScreen, arguments: {
      GetArgumentConstants.inspectionCreateRequestArg:
          inspectionCreateRequestModel,
    });
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      propertyDetail.value = args[GetArgumentConstants.propertyCard];
    }
  }

  @override
  void onInit() {
    getArguments();
    getScheduleInspectionList();
    super.onInit();
  }

  RxBool isShowLoader = false.obs;
  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  void onTapEditButton() {
    Get.toNamed(Routes.addPropertyScreen, arguments: {
      GetArgumentConstants.propertyDetail: propertyDetail.value,
      GetArgumentConstants.isPropertyDetailEdit: true
    })?.then((value) {
      if (value != null) {
        var result = value;
        if (result[0][GetArgumentConstants.isPropertyDetailEdit] == true) {
          Get.back(closeOverlays: true, result: [
            {GetArgumentConstants.isPropertyAdded: true}
          ]);
        }
      }
    });
  }

  void onTapDeleteButton() async {
    await showCommonAlertWithTwoActionsDialog(
        title: AppStrings.alert,
        leftButtonTitle: AppStrings.no,
        rightButtonTitle: AppStrings.yes,
        subHeader: AppStrings.areYouWantDelete,
        noPressed: () {
          Get.back();
        },
        yesPressed: () async {
          Get.back();
          await getDeleteProperty();
        });
  }

  Future<void> getDeleteProperty() async {
    setShowLoader(value: true);

    try {
      DeletePropertyResponseModel response = await propertyDetailProvider
              .deteleDetail(id: propertyDetail.value.id ?? "") ??
          DeletePropertyResponseModel();
      setShowLoader(value: false);
      if (response.success == true && (response.status == 204)) {
        //   //  snackbar(response.message ?? "");

        showCommonAlertSingleButtonDialog(
            title: AppStrings.alert,
            subHeader: response.message ?? "",
            okPressed: () {
              Get.back(closeOverlays: true, result: [
                {GetArgumentConstants.isPropertyAdded: true}
              ]);
              Get.back(closeOverlays: true, result: [
                {GetArgumentConstants.isPropertyAdded: true}
              ]);
            },
            buttonTitle: AppStrings.ok);
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

  Future<void> getScheduleInspectionList() async {
    setShowLoader(value: true);

    var body = json.encode({
      "property_id": "64c74829aa5a15e3162fb2d9",
      "user_id": "64c21cd6785e72f5e0b0e423",
      "search": "",
      "start": 0,
      "length": 10
    });

    try {
      ScheduleInspectionListResponseModel response =
          await propertyDetailProvider.getScheduleInspectionList(
                  id: propertyDetail.value.id ?? "", body: body) ??
              ScheduleInspectionListResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        //   //  sresponsenackbar(response.message ?? "");
        scheduleInspectionList.value = response.data ?? [];
        log("message>>>> ${scheduleInspectionList.value.length}");
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
