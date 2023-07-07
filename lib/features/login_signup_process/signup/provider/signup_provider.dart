import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/network_check.dart';

class SignUpProvider {
  NetworkCheck networkCheck = NetworkCheck();
  ApiHitter apiHitter = ApiHitter();
  bool isShowNoInternetConnectionpPopUp = true;
  Future<CardResponseModel?> getCard({required String cardNo}) async {
    if (await networkCheck.hasNetwork()) {
      var body = json.encode({
        "role_id": "620ca6e733032d8eb3c3b239",
        "register_type": "Email",
        "email": "inspector@yopmail.com",
        "phone": "457765655545",
        "country_code": 1,
        "password": "12345",
        "language_id": "6243ed27139b3b6b45b5b6dc",
        "state_id": "6243ed27139b3b6b45b4a6e1",
        "first_name": "inspector",
        "last_name": "user"
      });

      try {
        Response response =
            await apiHitter.postApi(endPoint: EndPoints.register, body: body);

        return CardResponseModel.fromJson(response.data);
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
      if (isShowNoInternetConnectionpPopUp) {
        networkCheck.noInternetConnectionDialog(
            // okPressed: () {
            //   getTemp.Get.back(closeOverlays: true);
            // },
            );
      }
    }
    return null;
  }
}
