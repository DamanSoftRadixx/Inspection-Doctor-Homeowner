import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/controller/add_property_controller.dart';

class AddPropertyBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddPropertyController>(() => AddPropertyController());
  }
}
