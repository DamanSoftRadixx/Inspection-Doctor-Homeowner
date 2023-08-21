import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/home/model/network_model/property_list_response_model.dart';

class HomeProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<PropertyListResponseModel?> propertyList(
      {required Object body, bool isCancelToken = false}) async {
    try {
      Response response = await apiHitter.postApi(
          endPoint: EndPoints.propertyList,
          body: body,
          isCancelToken: isCancelToken);

      log("gfdfdgdgdfg $response");
      PropertyListResponseModel data =
          PropertyListResponseModel.fromJson(response.data);
      showResponseData(data, type: 'propertyList');

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
