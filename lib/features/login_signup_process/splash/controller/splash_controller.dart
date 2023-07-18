import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/jwt_decoder.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/token_decode_response_model.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    navigateToNext();
    super.onInit();
  }

  Future navigateToNext() async {
    var token = Prefs.read(Prefs.token);
    Future.delayed(const Duration(seconds: 3), () {
      var token = Prefs.read(Prefs.token);
      var selectedLangId = Prefs.read(Prefs.selectedLangId);

      if (token != null && token != "") {
        LoginTokenModel loginTokenModel = getJsonFromJWTToken(token: token);
        var isOtpVerified = loginTokenModel.data?.isOtpVerified ?? 0;

        if (isOtpVerified == 0) {
          if (selectedLangId != null) {
            Get.toNamed(Routes.loginScreen);
          } else {
            Get.toNamed(Routes.selectLanguage);
          }
        } else {
          Get.toNamed(Routes.dashboard);
        }
      } else {
        if (selectedLangId != null) {
          Get.toNamed(Routes.loginScreen);
        } else {
          Get.toNamed(Routes.selectLanguage);
        }
      }
    });
  }
}
