import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/forgetPassword/model/network/forgot_password_response_model.dart';

class ForgotPasswordProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<ForgotPasswordResponseModel?> forgotPassword({required Object body}) async {
      try {
        Response response = await apiHitter.postApi(
            endPoint: EndPoints.forgotPassword, body: body);
        ForgotPasswordResponseModel data = ForgotPasswordResponseModel.fromJson(response.data);
        showResponseData(data, type: 'ForgotPassword');

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
