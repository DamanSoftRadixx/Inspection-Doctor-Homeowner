import 'package:get/get.dart';

class PaymentController extends GetxController {
  var isShowLoader = false.obs;
  setShowLoader({required bool value}) {
    isShowLoader.value = value;
    isShowLoader.refresh();
  }
}
