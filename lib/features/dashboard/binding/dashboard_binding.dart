import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/dashboard/controller/dashboard_controller.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
            () => DashboardController());
  }
}