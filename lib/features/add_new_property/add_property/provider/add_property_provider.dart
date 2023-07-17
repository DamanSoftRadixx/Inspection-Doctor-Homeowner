import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/add_property_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/get_county_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/property_update_response_model.dart';
import 'package:inspection_doctor_homeowner/features/add_new_property/add_property/model/network_model/upload_doc_response_model.dart';

class AddPropertyProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<AddPropertyResponseModel?> addProperty({required Object body}) async {
    try {
      Response response =
          await apiHitter.postApi(endPoint: EndPoints.addProperty, body: body);

      AddPropertyResponseModel data =
          AddPropertyResponseModel.fromJson(response.data);
      showResponseData(data, type: 'addProperty');

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

  Future<GetCountyResponseModel?> counties() async {
    try {
      Response response = await apiHitter.getApi(
        endPoint: EndPoints.getCounties,
      );

      GetCountyResponseModel data =
          GetCountyResponseModel.fromJson(response.data);
      showResponseData(data, type: 'counties');

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

  Future<UploadDocResponseModel?> uploadDoc({required Object body}) async {
    try {
      Response response =
          await apiHitter.multiPart(endPoint: EndPoints.uploadDoc, body: body);

      UploadDocResponseModel data =
          UploadDocResponseModel.fromJson(response.data);
      showResponseData(data, type: 'uploadDoc');

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

  Future<PropertyUpdateResponseModel?> updatePropertyDetail(
      {required Object body, required String id}) async {
    try {
      Response response = await apiHitter.postApi(
        endPoint: "${EndPoints.updateProperty}/$id",
        body: body,
      );

      PropertyUpdateResponseModel data =
          PropertyUpdateResponseModel.fromJson(response.data);
      showResponseData(data, type: 'updatePropertyDetail');

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
