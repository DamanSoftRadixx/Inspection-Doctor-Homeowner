import 'package:dio/dio.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/api_hitter.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/utils/ui_utils.dart';
import 'package:inspection_doctor_homeowner/features/inspection_details/give_feedback/model/network/feedback_response_model.dart';

class GiveFeedbackProvider {
  ApiHitter apiHitter = ApiHitter();

  Future<FeedbackResponseModel?> addFeedback(
      {required Object body, required String id}) async {
    try {
      Response response = await apiHitter.postApi(
          endPoint: "${EndPoints.addFeedBack}$id", body: body);

      FeedbackResponseModel data =
          FeedbackResponseModel.fromJson(response.data);
      showResponseData(data, type: 'addFeedback');

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
