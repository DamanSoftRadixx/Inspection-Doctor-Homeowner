import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/controller/controller.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}
