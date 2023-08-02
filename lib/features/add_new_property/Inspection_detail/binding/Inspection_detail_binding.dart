import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/controller/Inspection_detail_controller.dart';

class InspectionDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionDetailController>(() => InspectionDetailController());
  }
}
