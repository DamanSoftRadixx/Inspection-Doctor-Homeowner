import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError({required dio.DioException dioError}) {
    log("DioException $dioError}");
    switch (dioError.type) {
      case dio.DioExceptionType.cancel:
        // apiErrorDialog(
        //   message: AppStrings.strSometingWentWrong,
        //   okButtonPressed: () {
        //     Get.back();
        //   },
        // );
        break;
      case dio.DioExceptionType.connectionTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.receiveTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.connectionError:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      case dio.DioExceptionType.badResponse:
        dio.Response? response = dioError.response;
        var data = response?.data;
        var message = data["message"];
        apiErrorDialog(
          message: message ?? AppStrings.strSometingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      case dio.DioExceptionType.sendTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.unknown:
        apiErrorDialog(
          message: AppStrings.strSometingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      default:
        apiErrorDialog(
          message: AppStrings.strSometingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
    }
  }
}

apiErrorDialog(
    {String? title, required String message, Function()? okButtonPressed}) {
  showCommonAlertSingleButtonDialog(
      title: title ?? AppStrings.strError,
      subHeader: message,
      okPressed: () {
        (okButtonPressed != null) ? okButtonPressed() : Get.back();
      },
      buttonTitle: 'Ok');
}
