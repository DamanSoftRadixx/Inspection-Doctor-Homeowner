import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/choose_map/controller/choose_map_controller.dart';

class ChooseMapBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChooseMapController>(() => ChooseMapController());
  }
}
