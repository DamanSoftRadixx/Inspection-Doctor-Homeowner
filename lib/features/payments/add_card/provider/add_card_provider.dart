import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/payments/add_card/network_model/network/add_card_response_model.dart';

class AddCardProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<AddCardResponseModel?> addCard({required Object body}) async {
    try {
      Response response =
          await apiHitter.postApi(endPoint: EndPoints.createCard, body: body);
      log("addCard $response");
      AddCardResponseModel data = AddCardResponseModel.fromJson(response.data);
      showResponseData(data, type: 'addCard');

      return data;
    } catch (e) {
      if (e is DioException) {
        //This is the custom message coming from the backend
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception(e.toString());
      }
    }
  }
}
