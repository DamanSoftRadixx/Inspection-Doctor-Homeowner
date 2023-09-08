import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_keys.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/scheduled_property/model/network/request/get_report_response_model.dart';

class ReportViewController extends GetxController {
  Rx<GetReportResponseModelData> reportData = GetReportResponseModelData().obs;
  getArguments() {
    var args = Get.arguments;
    if (args != null) {
      reportData.value = args[GetArgumentConstants.reportData];
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getArguments();
    super.onInit();
  }
}
