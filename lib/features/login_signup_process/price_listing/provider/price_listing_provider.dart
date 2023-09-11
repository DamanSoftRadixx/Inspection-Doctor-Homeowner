import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/login_signup_process/price_listing/model/network/categories_response_model.dart';

class PriceListingProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<CategoriesResponseModel?> categoryList() async {
    try {
      Response response =
          await apiHitter.getApi(endPoint: EndPoints.categoryList, body: {});

      CategoriesResponseModel data =
          CategoriesResponseModel.fromJson(response.data);
      showResponseData(data, type: 'CategoryList');

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
