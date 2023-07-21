import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/splash/model/network/get_role_model.dart';

class SplashProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<GetRolesResponse?> getRoles() async {
    try {
      Response response = await apiHitter.getApi(endPoint: EndPoints.getRoles);

      GetRolesResponse data = GetRolesResponse.fromJson(response.data);

      showResponseData(
        data,
        type: 'getRoles',
      );

      return data;
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception(e.toString());
      }
    }
  }
}
