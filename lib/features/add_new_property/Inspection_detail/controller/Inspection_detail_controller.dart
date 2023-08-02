import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/categoriesForm/provider/categories_form_provider.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/request_model/inspection_create_request_model.dart';

class InspectionDetailController extends GetxController {
  CategoryFormProvider categoryFormProvider = CategoryFormProvider();
  @override
  void onInit() {
    getArguments();
    // getCategoryList();

    super.onInit();
  }

  RxBool isShowLoader = false.obs;
  Rx<ScheduleInspectionResponseData> inspectionDetail =
      ScheduleInspectionResponseData().obs;
  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      inspectionDetail.value = args[GetArgumentConstants.inspectionDetail] ??
          InspectionCreateRequestModel();
    }
  }
}
