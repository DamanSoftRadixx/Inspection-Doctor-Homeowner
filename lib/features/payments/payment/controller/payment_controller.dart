import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/snackbar/snackbar.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/model/network_model/card_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/provider/payment_provider.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/model/request_model/inspection_create_request_model.dart';

import '../../../schedule_an_Inspection/select_categories/model/network/category_list_response_model.dart';

class PaymentController extends GetxController {
  PaymentProvider paymentProvider = PaymentProvider();
  var isShowLoader = false.obs;

  RxList<CardListModelData> cardList = <CardListModelData>[].obs;
  Rx<InspectionCreateRequestModel> argData = InspectionCreateRequestModel().obs;

  Rx<CardListModelData> selectedCard = CardListModelData().obs;
  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  getCardList() async {
    setShowLoader(value: true);

    try {
      CardListModel response =
          await paymentProvider.cardList() ?? CardListModel();

      setShowLoader(value: false);

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        cardList.value = response.data?.data ?? [];
      } else {
        setShowLoader(value: false);
        apiErrorDialog(
          message: response.message ?? AppStrings.somethingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
      }
    } catch (e) {
      isShowLoader.value = false;
    }
  }

  Future<void> createInspection() async {
    setShowLoader(value: true);

    argData.value.cardId = selectedCard.value.id;
    log("message ${selectedCard.value.id}");

    var body = json.encode(argData.value);
    log("message $body");
    try {
      CategoryListResponseModel response =
          await paymentProvider.createInspection(body: body) ??
              CategoryListResponseModel();
      setShowLoader(value: false);
      if (response.success == true &&
          (response.status == 200 || response.status == 201)) {
        // showCommonAlertSingleButtonDialog(
        //     title: AppStrings.alert.tr,
        //     subHeader: response.message ?? "",
        //     okPressed: () {
        //       Get.until((route) =>
        //           route.settings.name == Routes.propertyDetailScreen
        //               ? true
        //               : false);
        //     },
        //     buttonTitle: AppStrings.ok.tr);

        snackbar(response.message ?? "");
        Get.until((route) =>
            route.settings.name == Routes.propertyDetailScreen ? true : false);
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

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      argData.value = args[GetArgumentConstants.createInspectionData] ??
          InspectionCreateRequestModel();
    }
  }

  void tapOnAddCard() {
    Get.toNamed(Routes.addCardScreen)?.then((value) {
      if (value != null) {
        bool result = value[0][GetArgumentConstants.isNeedToUpdateList];

        if (result == true) {
          getCardList();
        }
      }
    });
  }

  @override
  void onInit() {
    getArguments();
    getCardList();
    super.onInit();
  }
}
