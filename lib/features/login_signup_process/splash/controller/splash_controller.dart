import 'dart:developer';

import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/chage_language.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/enum.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/jwt_decoder.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/token_decode_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/model/network/get_role_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/provider/splash_provider.dart';

class SplashController extends GetxController {
  SplashProvider splashProvider = SplashProvider();
  @override
  void onInit() {
    changeLanguage();
    getRole();
    navigateToNext();
    super.onInit();
  }

  Future navigateToNext() async {
    Future.delayed(const Duration(seconds: 3), () {
      var token = Prefs.read(Prefs.token);

      if (token != null && token != "") {
        TokenResponseModel loginTokenModel = getJsonFromJWTToken(token: token);
        var isOtpVerified = loginTokenModel.data?.isOtpVerified ?? 0;

        log("token>>>> $isOtpVerified");

        if (isOtpVerified == 0) {
          // if (selectedLangId != null) {
          //   Get.toNamed(Routes.loginScreen);
          // } else {
          //   Get.toNamed(Routes.selectLanguage);
          // }
          Get.toNamed(Routes.loginScreen);
        } else {
          Get.toNamed(Routes.dashboard);
        }
      } else {
        // if (selectedLangId != null) {
        //   Get.toNamed(Routes.loginScreen);
        // } else {
        //   Get.toNamed(Routes.selectLanguage);
        // }
        Get.toNamed(Routes.loginScreen);
      }
    });
  }

  getRole() async {
    GetRolesResponse response =
        await splashProvider.getRoles() ?? GetRolesResponse();

    if (response.success == true &&
        (response.status == 201 || response.status == 200)) {
      response.data?.roles?.map((e) {
        if (e.name == RoleTypeEnum.homeowner.value) {
          Prefs.write(Prefs.homeownerRollId, e.id);
        }
      }).toList();
    }
  }
}
