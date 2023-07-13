import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/network_check.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/model/get_role_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/selectLanguage/model/select_language_model.dart';

class SelectLanguageProvider {
  NetworkCheck networkCheck = NetworkCheck();
  ApiHitter apiHitter = ApiHitter();

  Future<GetLangaugeResponseModel?> getLanguages() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Options options = Options(headers: headers);
    if (await networkCheck.hasNetwork()) {
      try {
        Response response = await apiHitter.getApi(
            endPoint: EndPoints.getLanguages, options: options);

        GetLangaugeResponseModel data =
            GetLangaugeResponseModel.fromJson(response.data);

        showResponseData(
          data,
          type: 'getLanguages',
        );

        return data;
      } catch (e) {
        if (e is DioException) {
          throw DioExceptions.fromDioError(dioError: e);
        }

        // if (e is DioException) {
        //   throw DioExceptions.fromDioError(dioError: e);
        // } else {
        //   log("getLanguages $e");
        //   apiErrorDialog(
        //     message: AppStrings.strSometingWentWrong,
        //     okButtonPressed: () {
        //       getx.Get.back();
        //     },
        //   );
        //   // throw Exception(e.toString());
        // }
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

  Future<GetRolesResponse?> getRoles() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};
    Options options = Options(headers: headers);
    if (await networkCheck.hasNetwork()) {
      try {
        Response response = await apiHitter.getApi(
            endPoint: EndPoints.getRoles, options: options);

        GetRolesResponse data = GetRolesResponse.fromJson(response.data);

        showResponseData(
          data,
          type: 'getRoles',
        );

        return data;
      } catch (e) {
        if (e is DioException) {
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

apiErrorDialog(
    {String? title, required String message, Function()? okButtonPressed}) {
  showCommonAlertSingleButtonDialog(
      title: title ?? AppStrings.strError,
      subHeader: message,
      okPressed: () {
        getx.Get.back();
        if (okButtonPressed != null) okButtonPressed();
      },
      buttonTitle: 'Ok');
}
