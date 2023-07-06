import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:grand_spin/core/common_ui/common_dialogs.dart';
import 'package:grand_spin/core/constants/app_strings.dart';

class DioExceptions implements Exception {
  DioExceptions.fromDioError({required DioException dioError}) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        // apiErrorDialog(
        //   message: AppStrings.strSometingWentWrong,
        //   okButtonPressed: () {
        //     Get.back();
        //   },
        // );
        break;
      case DioExceptionType.connectionTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case DioExceptionType.receiveTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case DioExceptionType.connectionError:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      case DioExceptionType.badResponse:
        apiErrorDialog(
          message: AppStrings.strSometingWentWrong,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;

      case DioExceptionType.sendTimeout:
        apiErrorDialog(
          message: AppStrings.connectionTimeOut,
          okButtonPressed: () {
            Get.back();
          },
        );
        break;
      case DioExceptionType.unknown:
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

  apiErrorDialog(
      {String? title, required String message, Function()? okButtonPressed}) {
    showCommonAlertSingleButtonDialog(
        title: title ?? AppStrings.strError,
        subHeader: message,
        okPressed: () {
          Get.back();
          if (okButtonPressed != null) okButtonPressed();
        },
        buttonTitle: 'Ok');
  }
}
