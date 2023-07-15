import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigateToNext();
    super.onInit();
  }

  Future navigateToNext() async {
    var token = Prefs.read(Prefs.token);
    Future.delayed(const Duration(seconds: 3), () {

      token == null
          ? Get.offNamed(Routes.selectLanguage)
          : Get.offNamed(Routes.dashboard);


    });
  }
}
