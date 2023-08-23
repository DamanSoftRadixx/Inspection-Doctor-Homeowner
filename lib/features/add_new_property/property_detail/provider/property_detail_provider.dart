import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/delete_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/property_detail/model/network_model/schedule_inspection_list_response_model.dart';

class PropertyDetailProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<DeletePropertyResponseModel?> deteleDetail(
      {required String id}) async {
    try {
      Response response = await apiHitter.deleteApi(
        endPoint: "${EndPoints.deleteProperty}/$id",
      );

      log("getScheduleInspectionListgdgfdg ${response.data}");

      DeletePropertyResponseModel data =
          DeletePropertyResponseModel.fromJson(response.data);
      showResponseData(data, type: 'deteleDetail');

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

  Future<ScheduleInspectionListResponseModel?> getScheduleInspectionList(
      {required String id,
      required Object body,
      bool isCancelToken = false}) async {
    try {
      Response response = await apiHitter.postApi(
          endPoint: EndPoints.scheduleInspectionList,
          body: body,
          isCancelToken: isCancelToken);

      log("getScheduleInspectionList $response");

      ScheduleInspectionListResponseModel data =
          ScheduleInspectionListResponseModel.fromJson(response.data);

      showResponseData(data, type: 'getScheduleInspectionList');

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
