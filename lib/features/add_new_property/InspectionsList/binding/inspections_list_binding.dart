import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/InspectionsList/controller/inspections_list_controller.dart';

class InspectionsListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InspectionsListController>(() => InspectionsListController());
  }
}
