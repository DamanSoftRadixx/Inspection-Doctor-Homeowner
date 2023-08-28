import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/report_view/controller/report_view_controller.dart';

class ReportViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReportViewController>(() => ReportViewController());
  }
}
