import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';

class CategoryFormProvider {
  ApiHitter apiHitter = ApiHitter();

  // Future<CategoryListResponseModel?> createInspection(
  //     {required Object body}) async {
  //   try {
  //     Response response = await apiHitter.postApi(
  //       endPoint: EndPoints.inspectionCreate,
  //       body: body,
  //     );

  //     CategoryListResponseModel data =
  //         CategoryListResponseModel.fromJson(response.data);
  //     showResponseData(data, type: 'createInspection');

  //     return data;
  //   } catch (e) {
  //     if (e is DioException) {
  //       //This is the custom message coming from the backend
  //       throw DioExceptions.fromDioError(dioError: e);
  //     } else {
  //       throw Exception(e.toString());
  //     }
  //   }
  // }
}
