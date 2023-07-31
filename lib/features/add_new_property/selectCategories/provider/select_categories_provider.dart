import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/selectCategories/model/network/category_list_response_model.dart';

class SelectCategoriesProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<CategoryListResponseModel?> categoryList(
      {required Object body}) async {
    try {
      Response response = await apiHitter.postApi(
        endPoint: EndPoints.categorySubcategory,
        body: body,
      );

      CategoryListResponseModel data =
          CategoryListResponseModel.fromJson(response.data);
      showResponseData(data, type: 'categoryList');

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
