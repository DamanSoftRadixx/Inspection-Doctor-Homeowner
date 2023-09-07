import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/propertyDetail/controller/property_detail_controller.dart';

class PropertyDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PropertyDetailController>(() => PropertyDetailController());
  }
}
