import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as getx;
import 'package:inspection_doctor_homeowner/core/common_functionality/logout/model/logout_response_model.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/google_address_response_model.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/model/select_language_model.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';

class CommonProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<LogoutResponseModel?> logOutAPI() async {
    try {
      Response response = await apiHitter.postApi(endPoint: EndPoints.logOut);

      LogoutResponseModel data = LogoutResponseModel.fromJson(response.data);
      Prefs.erase();
      getx.Get.offAllNamed(Routes.loginScreen);

      showResponseData(
        data,
        type: 'logOutAPI',
      );
      return data;
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      }
    }
    return null;
  }

  Future<GetLangaugeResponseModel?> getLanguages() async {
    try {
      Response response =
          await apiHitter.getApi(endPoint: EndPoints.getLanguages);

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
    }
    return null;
  }

  Future<GoogleAddressResponseModel?> getGoogleAddress(
      {required String placeid}) async {
    log("getGoogleAddressURl ${"${EndPoints.googleMapUrl}placeid=$placeid&key=${EndPoints.mapKey}"}");
    try {
      Response response = await apiHitter.getGoogleAddressApi(
          endPoint:
              "${EndPoints.googleMapUrl}placeid=$placeid&key=${EndPoints.mapKey}");

      GoogleAddressResponseModel data =
          GoogleAddressResponseModel.fromJson(response.data);
      showResponseData(
        data,
        type: 'getGoogleAddress',
      );
      return data;
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      }
    }
    return null;
  }
}
