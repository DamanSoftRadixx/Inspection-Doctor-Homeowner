// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
// import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
// import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';
// import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
// import 'package:inspection_doctor_homeowner/core/network_utility/custom_http_client.dart';
// import 'package:inspection_doctor_homeowner/core/network_utility/network_check.dart';
// import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';

// class ApiHitter implements CustomHttpClient {
//   ApiHitter({required final String urlBase}) {
//     dio.options = BaseOptions(
//       baseUrl: urlBase,
//       connectTimeout: connectTimeout,
//       receiveTimeout: receiveTimeout,
//       sendTimeout: sendTimeout,
//       responseType: ResponseType.json,
//     );
//   }

//   static final ApiHitter shared = ApiHitter._internal();
//   var networkCheck = NetworkCheck();

//   factory ApiHitter() {
//     return shared;
//   }

//   changeTimeoutTime({required int timeoutMinutes}) {
//     timeout = Duration(minutes: timeoutMinutes);
//   }

//   ApiHitter._internal();

//   // getApi(
//   //     {required String endPoint,
//   //     bool isShowNoInternetConnectionpPopUp = false}) async {
//   //   try {
//   //     if (await networkCheck.hasNetwork()) {
//   //       var token = Prefs.read(Prefs.TOKEN) == null
//   //           ? ""
//   //           : "Bearer ${Prefs.read(Prefs.TOKEN)}";
//   //       // var token = await Prefs.read(Prefs.TOKEN) ?? "";
//   //       // var acceptLanguage = await Prefs.read(Prefs.selectedLang) ?? "";

//   //       Map<String, String> headers = {
//   //         'Accept': 'application/json',
//   //         'Content-type': 'application/json',
//   //         "Authorization": token,
//   //       };

//   //       print("GET URL : ${EndPoints.BASE_URL + endPoint}");
//   //       print("TOKEN : $token");

//   //       var response =
//   //           await get(EndPoints.BASE_URL + endPoint, headers: headers);

//   //       print("RESPONSE ($endPoint) >>>>>>> ${response.body}");

//   //       return responseParser(response: response);
//   //     } else {
//   //       if (isShowNoInternetConnectionpPopUp) {
//   //         networkCheck.noInternetConnectionDialog();
//   //       }
//   //     }
//   //   } catch (e) {
//   //     print(e.toString());
//   //   }
//   // }

//   deleteApi(
//       {required String endPoint,
//       bool isShowNoInternetConnectionpPopUp = false}) async {
//     try {
//       if (await networkCheck.hasNetwork()) {
//         var token = Prefs.read(Prefs.TOKEN) == null
//             ? ""
//             : "Bearer ${Prefs.read(Prefs.TOKEN)}";
//         var acceptLanguage = await Prefs.read(Prefs.selectedLang) ?? "";

//         Map<String, String> headers = {
//           'Accept': 'application/json',
//           'Content-type': 'application/json',
//           "Authorization": token,
//           'Accept-Language': acceptLanguage.toString().toLowerCase()
//         };

//         print("GET URL : ${EndPoints.BASE_URL + endPoint}");
//         print("TOKEN : $token");

//         var response =
//             await delete(EndPoints.BASE_URL + endPoint, headers: headers);

//         print("RESPONSE ($endPoint) >>>>>>> ${response.body}");

//         return responseParser(response: response);
//       } else {
//         if (isShowNoInternetConnectionpPopUp) {
//           networkCheck.noInternetConnectionDialog();
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   postApi({
//     required String endPoint,
//     Function(Response response)? onPressErrorOkButton,
//     required Map<String, dynamic> body,
//     bool isShowNoInternetConnectionpPopUp = false,
//   }) async {
//     try {
//       if (await networkCheck.hasNetwork()) {
//         /*if(endPoint == EndPoints.autoSaveData){
//           httpClient.close();
//         }*/

//         var token = Prefs.read(Prefs.TOKEN) == null
//             ? ""
//             : "Bearer ${Prefs.read(Prefs.TOKEN)}";
//         print("tokennnn---->>>>$token");
//         /*var acceptLanguage = await Prefs.read(Prefs.selectedLang) ?? "";*/

//         Map<String, String> headers = {
//           'Accept': 'application/json',
//           'Content-type': 'application/json',
//           "Authorization": token ?? "",
//           /*'Accept-Language' :acceptLanguage.toString().toLowerCase()*/
//         };

//         print("POST URL : ${EndPoints.BASE_URL + endPoint}");
//         print("TOKEN : $token");
//         print("REQUEST ($endPoint) >>>>>>> $body");

//         var response =
//             await post(EndPoints.BASE_URL + endPoint, body, headers: headers);
//         print("RESPONSE ($endPoint) >>>>>>> ${response.body}");

//         var isFromLogined = endPoint == EndPoints.login ? true : false;
//         return responseParser(
//             response: response,
//             onPressErrorOkButton: onPressErrorOkButton,
//             isFromLogin: isFromLogined);
//       } else {
//         if (isShowNoInternetConnectionpPopUp) {
//           networkCheck.noInternetConnectionDialog();
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   putApi(
//       {required String endPoint,
//       required dynamic body,
//       bool isShowNoInternetConnectionpPopUp = false}) async {
//     try {
//       if (await networkCheck.hasNetwork()) {
//         var token = Prefs.read(Prefs.TOKEN) == null
//             ? ""
//             : "Bearer ${Prefs.read(Prefs.TOKEN)}";
//         var acceptLanguage = await Prefs.read(Prefs.selectedLang) ?? "";

//         Map<String, String> headers = {
//           'Accept': 'application/json',
//           'Content-type': 'application/json',
//           "Authorization": token,
//           'Accept-Language': acceptLanguage.toString().toLowerCase()
//         };
//         print("PUT URL : ${EndPoints.BASE_URL + endPoint}");
//         print("TOKEN : $token");
//         print("REQUEST ($endPoint) >>>>>>> $body");

//         var response =
//             await put(EndPoints.BASE_URL + endPoint, body, headers: headers);
//         print("RESPONSE ($endPoint) >>>>>>> ${response.body}");

//         return responseParser(response: response);
//       } else {
//         if (isShowNoInternetConnectionpPopUp) {
//           networkCheck.noInternetConnectionDialog();
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   multipartPostApi(
//       {required String endPoint,
//       required String imagePath,
//       bool isShowNoInternetConnectionpPopUp = false}) async {
//     try {
//       if (await networkCheck.hasNetwork()) {
//         var request = http.MultipartRequest(
//             'POST', Uri.parse(EndPoints.BASE_URL + endPoint));

//         var token = Prefs.read(Prefs.TOKEN) == null
//             ? ""
//             : "Bearer ${Prefs.read(Prefs.TOKEN)}";
//         var acceptLanguage = await Prefs.read(Prefs.selectedLang) ?? "";

//         Map<String, String> headers = {
//           'Accept': 'application/json',
//           'Content-type': 'application/json',
//           "Authorization": token,
//           'Accept-Language': acceptLanguage.toString().toLowerCase()
//         };
//         request.headers.addAll(headers);

//         print("MULTIPART URL : ${EndPoints.BASE_URL + endPoint}");
//         print("TOKEN : $token");
//         print("REQUEST ($endPoint) >>>>>>> $imagePath");

//         if (imagePath.isNotEmpty) {
//           request.files.add(http.MultipartFile.fromBytes(
//               'files', File(imagePath).readAsBytesSync(),
//               filename: imagePath.split("/").last));
//         }

//         var updateRequest = await request.send();

//         updateRequest.stream.transform(utf8.decoder).listen((value) {
//           var jsondata = json.decode(value);
//           print("RESPONSE ($endPoint) >>>>>>> $jsondata");

//           int statusCode = jsondata['code'].toString().toIntConversion();
//           var message = jsondata["message"].toString().toStringConversion();
//           var error = jsondata["error"].toString().toStringConversion();
//           if (statusCode == 401) {
//             sessionExpiredDialog();
//           } else if (statusCode == 404) {
//             apiErrorDialog(message: message ?? AppStrings.strSometingWentWrong);
//           } else if (statusCode == 403 || statusCode == 500) {
//             if (message == null || message == "") {
//               apiErrorDialog(message: error ?? AppStrings.strSometingWentWrong);
//             } else {
//               apiErrorDialog(
//                   message: message ?? AppStrings.strSometingWentWrong);
//             }
//           } else if (statusCode == 200 ||
//               statusCode == 201 ||
//               statusCode == 202) {
//             return jsondata;
//           } else {
//             apiErrorDialog(message: message ?? AppStrings.strSometingWentWrong);
//           }
//         });
//       } else {
//         if (isShowNoInternetConnectionpPopUp) {
//           networkCheck.noInternetConnectionDialog();
//         }
//       }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   sessionExpiredDialog() {
//     showCommonAlertWithTwoActionsDialog(
//         title: AppStrings.strSessionExpired.tr,
//         subHeader: AppStrings.strSessionExpiredWarning.tr,
//         okPressed: () {
//           Get.back();
//         });
//   }

//   apiErrorDialog(
//       {String? title, required String message, Function()? okButtonPressed}) {
//     showCommonAlertSingleButtonDialog(
//         title: title ?? AppStrings.strError,
//         subHeader: message,
//         okPressed: () {
//           Get.back();
//           if (okButtonPressed != null) okButtonPressed();
//         },
//         buttonTitle: '');
//   }

//   responseParser(
//       {required Response response,
//       Function(Response response)? onPressErrorOkButton,
//       bool isFromLogin = false}) {
//     log("HTTP Status Code ${response.statusCode}");
//     if (response.hasError && response.body == null) {
//       var errorText = response.statusText ?? "";
//       print("Response Error : $errorText");
//       if (errorText.toLowerCase().contains("timed out")) {
//         apiErrorDialog(
//             message: AppStrings.strPleaseCheckYourInternetConnectivity);
//       } else {
//         apiErrorDialog(message: AppStrings.strSometingWentWrong);
//       }
//     } else {
//       var statusCode = response.body["code"].toString().toIntConversion();
//       if (statusCode == 0) {
//         statusCode = response.statusCode.toString().toIntConversion();
//       }
//       var message = response.body["message"].toString().toStringConversion();
//       var error = response.body["error"].toString().toStringConversion();
//       if (statusCode == 400 || statusCode == 422) {
//         if (isFromLogin) {
//           return response;
//         }
//         sessionExpiredDialog();
//       } else if (statusCode == 401) {
//         apiErrorDialog(message: error ?? AppStrings.strSometingWentWrong);
//       } else if (statusCode == 404) {
//         apiErrorDialog(message: message ?? AppStrings.strSometingWentWrong);
//       } else if (statusCode == 403 || statusCode == 500) {
//         if (message == null || message == "") {
//           apiErrorDialog(message: error ?? AppStrings.strSometingWentWrong);
//         } else {
//           apiErrorDialog(message: message ?? AppStrings.strSometingWentWrong);
//         }
//       } else if (statusCode == 200 || statusCode == 201 || statusCode == 202) {
//         return response;
//       } else {
//         apiErrorDialog(
//             message: message ?? AppStrings.strSometingWentWrong,
//             okButtonPressed: () {
//               if (onPressErrorOkButton != null) onPressErrorOkButton(response);
//             });
//       }
//     }
//   }
// }

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/network_check.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';

class ApiHitter {
  static Dio dio = Dio();
  static CancelToken cancelToken = CancelToken();
  final GlobalKey key = GlobalKey();
  NetworkCheck networkCheck = NetworkCheck();

  postApi(
      {required String endPoint,
        required Object body,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        CancelToken? cancelToken,
        Map<String, dynamic>? queryParameters}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      print("URL ${endPoint} >> ${url}");
      print("POST ${endPoint} >> ${body}");
      print("POST ${endPoint} >> ${queryParameters}");

      if (await networkCheck.hasNetwork()) {

        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";
        String token = await Prefs.read(Prefs.token) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'language_id': selectedLangId,
        };

        print("headers : ${headers}");
        print("token : ${token}");
        Options options = Options(headers: headers);

        var response = await dio.post(
          url,
          options: options,
          data: body,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        );
        return response;
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error");
      }
    }
  }

  putApi(
      {required String endPoint,
        required Object body,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
        CancelToken? cancelToken,
        Map<String, dynamic>? queryParameters}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      print("URL ${endPoint} >> ${url}");
      print("PUT ${endPoint} >> ${body}");

      if (await networkCheck.hasNetwork()) {

        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";
        String token = await Prefs.read(Prefs.token) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'language_id': selectedLangId,
        };

        print("headers : ${headers}");
        print("token : ${token}");
        Options options = Options(headers: headers);

        var response = await dio.put(
          url,
          options: options,
          data: body,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        );
        return response;
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error");
      }
    }
  }

  getApi({
    required String endPoint,
    Object? body,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    CancelToken? cancelToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      print("URL ${endPoint} >> ${url}");
      print("GET ${endPoint} >> ${queryParameters}");
      if (await networkCheck.hasNetwork()) {
        Map<String, String> headers = {'Content-Type': 'application/json'};
        Options options = Options(headers: headers);
        print("headers : ${headers}");

        Response response = await dio.get(
          url,
          options: options,
          data: body,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          queryParameters: queryParameters,
        );
        return response;
      } else {
        log("no internet issue");
        networkCheck.noInternetConnectionDialog();
      }
    } catch (e) {
      if (e is DioException) {
        throw DioExceptions.fromDioError(dioError: e);
      } else {
        throw Exception("Error");
      }
    }
  }

  Future<bool> cancelRequests() async {
    cancelToken.cancel();
    return cancelToken.isCancelled;
  }
}
