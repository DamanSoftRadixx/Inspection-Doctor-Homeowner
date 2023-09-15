import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/model/network_model/card_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/provider/payment_provider.dart';

class PaymentController extends GetxController {
  PaymentProvider paymentProvider = PaymentProvider();
  var isShowLoader = false.obs;

  RxList<CardListModelData> cardList = <CardListModelData>[].obs;
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

  @override
  void onInit() {
    getCardList();
    super.onInit();
  }
}
