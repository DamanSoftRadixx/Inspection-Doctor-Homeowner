import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/scheduled_property/controller/Inspection_detail_controller.dart';

class InspectionDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionDetailController>(() => InspectionDetailController());
  }
}
