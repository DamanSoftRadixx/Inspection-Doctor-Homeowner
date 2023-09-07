import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/payment/controller/payment_controller.dart';

class PaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PaymentController>(() => PaymentController());
  }
}
