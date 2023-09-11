import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/model/network/categories_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/provider/price_listing_provider.dart';

class PriceListingController extends GetxController {
  PriceListingProvider priceListingProvider = PriceListingProvider();

  RxBool isShowLoader = false.obs;
  RxList<Category> list = <Category>[].obs;

  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }

  geCategoryListApi() async {
    setShowLoader(value: true);

    try {
      CategoriesResponseModel response =
          await priceListingProvider.categoryList() ??
              CategoriesResponseModel();

      setShowLoader(value: false);

      if (response.success == true &&
          (response.status == 201 || response.status == 200)) {
        list.value = response.data ?? [];
      } else {
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
    geCategoryListApi();
    super.onInit();
  }
}
