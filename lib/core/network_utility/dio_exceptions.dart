import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:inspection_doctor_homeowner/core/common_functionality/logout/logout_functionality.dart';
import 'package:inspection_doctor_homeowner/core/common_ui/common_dialogs.dart';
import 'package:inspection_doctor_homeowner/core/constants/app_strings.dart';
import 'package:inspection_doctor_homeowner/core/routes/routes.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';

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
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.receiveTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.connectionError:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      case dio.DioExceptionType.badResponse:
        dio.Response? response = dioError.response;

        var data = response?.data;

        var statusCode = response?.statusCode ?? 0;
        var statusMessage =
            response?.statusMessage ?? AppStrings.strSometingWentWrong.tr;

        if (statusCode == 413) {
          apiErrorDialog(
            message: statusMessage,
            okButtonPressed: () {
              Get.back();
            },
          );
        } else if (statusCode == 401) {
          apiErrorDialog(
            message: statusMessage,
            okButtonPressed: () {
              Prefs.erase();
              Get.offAllNamed(Routes.loginScreen);
            },
          );
        } else {
          var message = data["message"];
          var status = data["status"] ?? 0;

          if (status == 401) {
            logoutFunctionality();
            apiErrorDialog(
              message: message ?? AppStrings.strSometingWentWrong.tr,
              okButtonPressed: () {
                Get.back();
              },
            );
          } else {
            apiErrorDialog(
              message: message ?? AppStrings.strSometingWentWrong.tr,
              okButtonPressed: () {
                Get.back();
              },
            );
          }
        }

        break;

      case dio.DioExceptionType.sendTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case dio.DioExceptionType.unknown:
        apiErrorDialog(
          message: AppStrings.strSometingWentWrong.tr,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      default:
        apiErrorDialog(
          message: AppStrings.strSometingWentWrong.tr,
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
      title: title ?? AppStrings.strError.tr,
      subHeader: message,
      okPressed: () {
        (okButtonPressed != null) ? okButtonPressed() : Get.back();
      },
      buttonTitle: 'Ok');
}
