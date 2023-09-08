import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/schedule_an_Inspection/select_categories/model/network/category_list_response_model.dart';

class InspectionsListProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<CategoryListResponseModel?> categoryList(
      {required Object body, bool isCancelToken = false}) async {
    try {
      Response response = await apiHitter.postApi(
          endPoint: EndPoints.categorySubcategory,
          body: body,
          isCancelToken: isCancelToken);

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
