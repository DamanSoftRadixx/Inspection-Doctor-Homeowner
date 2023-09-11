import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/controller/price_listing_controller.dart';

class PriceListingBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PriceListingController>(() => PriceListingController());
  }
}
