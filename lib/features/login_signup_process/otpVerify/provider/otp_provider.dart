import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/network_check.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/model/verifiy_model.dart';

class OtpVerifyProvider {
  NetworkCheck networkCheck = NetworkCheck();
  ApiHitter apiHitter = ApiHitter();

  Future<OtpVerifyResponse?> otpVerification({required Object body}) async {
    String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";

    Map<String, String> headers = {
      'language_id': selectedLangId,
      'Content-Type': 'application/json',
      'accept': 'application/json'
    };
    Options options = Options(headers: headers);
    if (await networkCheck.hasNetwork()) {
      try {
        Response response = await apiHitter.postApi(
            endPoint: EndPoints.register, body: body, options: options);

        log("response>>>> $response");

        OtpVerifyResponse data = OtpVerifyResponse.fromJson(response.data);

        showResponseData(data, type: 'signUpUser');

        return data;
      } catch (e) {
        if (e is DioException) {
          //This is the custom message coming from the backend
          throw DioExceptions.fromDioError(dioError: e);
        } else {
          throw Exception(e.toString());
        }
      }
    } else {
      log("no internet issue");

      networkCheck.noInternetConnectionDialog(
          // okPressed: () {
          //   getTemp.Get.back(closeOverlays: true);
          // },
          );
    }
    return null;
  }
}
