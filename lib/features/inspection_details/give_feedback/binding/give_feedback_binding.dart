import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/controller/give_feedback_controller.dart';

class GiveFeedbackBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GiveFeedBackController>(() => GiveFeedBackController());
  }
}
