import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/payments/payment/model/network_model/card_list_response_model.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/model/network/category_list_response_model.dart';

class PaymentProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<CardListModel?> cardList() async {
    try {
      Response response = await apiHitter.getApi(
        endPoint: EndPoints.cardList,
      );

      log("response $response");

      CardListModel data = CardListModel.fromJson(response.data);
      showResponseData(data, type: 'cardList');

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

  Future<CategoryListResponseModel?> createInspection(
      {required Object body}) async {
    try {
      Response response = await apiHitter.postApi(
        endPoint: EndPoints.inspectionCreate,
        body: body,
      );

      log("createInspection $response");

      CategoryListResponseModel data =
          CategoryListResponseModel.fromJson(response.data);
      showResponseData(data, type: 'createInspection');

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
