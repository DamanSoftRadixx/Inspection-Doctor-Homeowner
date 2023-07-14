import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/resetPassword/model/network/reset_password_response_model.dart';

class ResetPasswordProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<ResetPasswordResponseModel?> resetPassword({required Object body}) async {
      try {

        String token = await Prefs.read(Prefs.token) ?? "";
        Response response = await apiHitter.putApi(
            endPoint: "${EndPoints.resetPassword}/${token}", body: body);
        ResetPasswordResponseModel data = ResetPasswordResponseModel.fromJson(response.data);
        showResponseData(data, type: 'ResetPassword');

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
