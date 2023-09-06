import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/notification/controller/notification_controller.dart';

class NotificationBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NotificationController>(() => NotificationController());
  }
}
