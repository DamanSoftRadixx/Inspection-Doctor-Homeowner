import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';

class PropertyDetailController extends GetxController {
  PropertyListData property = PropertyListData();
  onPressAddPropertyButton() {
    Get.back();
  }

  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      property = args[GetArgumentConstants.propertyCard];
    }
  }

  @override
  void onInit() {
    getArguments();
    // TODO: implement onInit
    super.onInit();
  }
}
