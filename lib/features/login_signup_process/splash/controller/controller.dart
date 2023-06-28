import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    navigateToNext();
    super.onInit();
  }

  Future navigateToNext() async {
    Future.delayed(const Duration(seconds: 2), () {
      // var token = Prefs.read(Prefs.TOKEN);
      // token == null
      //     ? Get.offNamed(Routes.introScreen)
      //     : Get.offNamed(Routes.dashboard);
    });
  }
}
