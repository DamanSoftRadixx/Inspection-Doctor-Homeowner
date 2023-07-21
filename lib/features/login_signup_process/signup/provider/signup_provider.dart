import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/models/network_model/select_language_model.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/signup/models/network_model/signup_model.dart';

class SignUpProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<SignUpResponseModel?> signUpUser({required Object body}) async {
    try {
      Response response =
          await apiHitter.postApi(endPoint: EndPoints.register, body: body);
      SignUpResponseModel data = SignUpResponseModel.fromJson(response.data);
      showResponseData(data, type: 'signUpUser');

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

  Future<GetLangaugeResponseModel?> getLanguages() async {
    try {
      Response response =
          await apiHitter.getApi(endPoint: EndPoints.getLanguages);

      GetLangaugeResponseModel data =
          GetLangaugeResponseModel.fromJson(response.data);
      showResponseData(
        data,
        type: 'getLanguages',
      );
      return data;
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      }
    }
    return null;
  }
}
