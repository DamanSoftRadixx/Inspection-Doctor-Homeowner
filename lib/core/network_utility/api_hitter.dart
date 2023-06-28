// import 'dart:convert';
// import 'dart:developer';
// import 'dart:io';

// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:inspection_doctor_homeowner/core/common_ui/app_end_points.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/common_functionality.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/local_storage.dart';
// import 'package:inspection_doctor_homeowner/core/common_ui/string_extensions.dart';
// import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

// import 'network_check.dart';

// class ApiHitter extends GetConnect {
//   static final ApiHitter shared = ApiHitter._internal();
//   var networkCheck = NetworkCheck();

//   factory ApiHitter() {
//     return shared;
//   }

//   changeTimeoutTime({required int timeoutMinutes}) {
//     timeout = Duration(minutes: timeoutMinutes);
//   }

//   ApiHitter._internal();

//   getApi(
//       {required String endPoint,
//       bool isShowNoInternetConnectionpPopUp = false}) async {
//     try {
//       if (await networkCheck.hasNetwork()) {
//         var token = Prefs.read(Prefs.TOKEN) == null
//             ? ""
//             : "Bearer ${Prefs.read(Prefs.TOKEN)}";
//         // var token = await Prefs.read(Prefs.TOKEN) ?? "";
//         // var acceptLanguage = await Prefs.read(Prefs.selectedLang) ?? "";

//         Map<String, String> headers = {
//           'Accept': 'application/json',
//           'Content-type': 'application/json',
//           "Authorization": token,
//         };

//         print("GET URL : ${EndPoints.BASE_URL + endPoint}");
//         print("TOKEN : $token");

//         var response =
//             await get(EndPoints.BASE_URL + endPoint, headers: headers);

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
//           CommonFunctionality().clearPrefAndLogout();
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
//         });
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
