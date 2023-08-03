import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/Inspection_detail/model/schedule_inspection_details_response_Model.dart';

class InspectionDetailProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<ScheduleInspectionDetailsResponseModel?> scheduleInspectionDetails(
      {required String id}) async {
    try {
      Response response = await apiHitter.getApi(
        endPoint: "${EndPoints.scheduleInspectionDetail}/$id",
      );
      log("response $response");

      ScheduleInspectionDetailsResponseModel data =
          ScheduleInspectionDetailsResponseModel.fromJson(response.data);
      showResponseData(data, type: 'scheduleInspectionDetails');

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
