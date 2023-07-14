
import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/model/network_model/resend_otp_response_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/otpVerify/model/network_model/verify_otp_response_model.dart';

class OtpVerifyProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<VerifyOtpResponseModel?> otpVerification({required Object body}) async {
    try {
      Response response =
          await apiHitter.postApi(endPoint: EndPoints.otpVerification, body: body);

      VerifyOtpResponseModel data = VerifyOtpResponseModel.fromJson(response.data);
      showResponseData(data, type: 'OtpVerification');

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

  Future<ResendOtpResponseModel?> resendOtp({required Object body}) async {
    try {
      Response response =
      await apiHitter.postApi(endPoint: EndPoints.resendOtp, body: body);

      ResendOtpResponseModel data = ResendOtpResponseModel.fromJson(response.data);
      showResponseData(data, type: 'ResendOtp');

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
