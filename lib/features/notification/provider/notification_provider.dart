import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/notification/model/network/notification_edit_response_model.dart';
import 'package:inspection_doctor_homeowner/features/notification/model/network/notification_response_model.dart';

class NotificationProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<NotificationResponseModel?> notificationList(
      {required Object body}) async {
    try {
      Response response =
          await apiHitter.postApi(endPoint: EndPoints.notification, body: body);

      NotificationResponseModel data =
          NotificationResponseModel.fromJson(response.data);
      showResponseData(data, type: 'notificationList');

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

  Future<NotificationEditModel?> editNotificationStatus(
      {required String id}) async {
    try {
      Response response = await apiHitter.putApi(
        endPoint: "${EndPoints.editNotification}$id",
      );

      NotificationEditModel data =
          NotificationEditModel.fromJson(response.data);
      showResponseData(data, type: 'editStatus');

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
