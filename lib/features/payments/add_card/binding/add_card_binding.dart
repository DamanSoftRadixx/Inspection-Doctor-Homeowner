import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/payments/add_card/controller/add_card_controller.dart';

class AddCardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCardController>(() => AddCardController());
  }
}
