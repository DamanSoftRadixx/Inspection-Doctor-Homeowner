import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/controller/property_detail_controller.dart';

class PropertyDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyDetailController>(() => PropertyDetailController());
  }
}
