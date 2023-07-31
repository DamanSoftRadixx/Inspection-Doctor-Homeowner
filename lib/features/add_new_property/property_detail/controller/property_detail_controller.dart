import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/delete_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/provider/property_detail_provider.dart';

class PropertyDetailController extends GetxController {
  PropertyDetailProvider propertyDetailProvider = PropertyDetailProvider();
  Rx<PropertyListData> propertyDetail = PropertyListData().obs;
  onPressAddPropertyButton() {
    Get.toNamed(Routes.selectCategoriesScreen);
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
}
