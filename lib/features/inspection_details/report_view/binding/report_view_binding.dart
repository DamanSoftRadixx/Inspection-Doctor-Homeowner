import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/report_view/controller/report_view_controller.dart';

class ReportViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportViewController>(() => ReportViewController());
  }
}
