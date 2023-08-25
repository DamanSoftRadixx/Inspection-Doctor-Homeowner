import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/app_end_points.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/dio_exceptions.dart';
import 'package:inspection_doctor_homeowner/core/network_utility/network_check.dart';
import 'package:inspection_doctor_homeowner/core/storage/local_storage.dart';
import 'package:get/get.dart' as getx;

class ApiHitter {
  static Dio dio = Dio();
  static CancelToken cancelToken = CancelToken();
  final GlobalKey key = GlobalKey();
  NetworkCheck networkCheck = NetworkCheck();

  postApi(
      {required String endPoint,
      Object? body,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress,
        bool isCancelToken = false,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headersParm}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      print("URL $endPoint >> $url");
      print("POST $endPoint >> $body");
      print("POST $endPoint >> $queryParameters");

      if (await networkCheck.hasNetwork()) {


        if(isCancelToken){
          cancelToken.cancel();

          if (cancelToken.isCancelled) {
            cancelToken = new CancelToken();
          }

        }

        String token = await Prefs.read(Prefs.token) ?? "";
        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";

        log("token>>>>>>> $token");

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'language_id': selectedLangId,
          'authorization': "Bearer $token",
        };
        log("headers>> $headers");

        headers.addAll(headersParm ?? {});

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

        var statusCode = response.data["status"] ?? 400;
        var statusMessage = response.data["message"] ?? 400;

        if(statusCode == 201 || statusCode == 200){
          return response;
        }else{
          apiErrorDialog(
            message: statusMessage ?? "",
            okButtonPressed: () {
              getx.Get.back();
            },
          );
        }

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
      print("URL $endPoint >> $url");
      print("PUT $endPoint >> $body");

      if (await networkCheck.hasNetwork()) {
        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";
        String token = await Prefs.read(Prefs.token) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'language_id': selectedLangId,
        };

        print("headers : $headers");
        print("token : $token");
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

  getApi(
      {required String endPoint,
      Object? body,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress,
      CancelToken? cancelToken,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headersParm}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      print("URL $endPoint >> $url");
      print("GET $endPoint >> $queryParameters");
      if (await networkCheck.hasNetwork()) {
        String token = await Prefs.read(Prefs.token) ?? "";
        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'language_id': selectedLangId,
          'authorization': "Bearer $token",
        };

        headers.addAll(headersParm ?? {});

        Options options = Options(headers: headers);

        print("headers : $headers");

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

  multiPart(
      {required String endPoint,
      Object? body,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress,
      CancelToken? cancelToken,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headersParm}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      print("URL $endPoint >> $url");
      print("POST $endPoint >> $body");
      print("POST $endPoint >> $queryParameters");

      if (await networkCheck.hasNetwork()) {
        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";

        Map<String, String> headers = {
          'accept': 'application/json',
          'Content-Type': 'multipart/form-data',
          'language_id': selectedLangId,
        };

        headers.addAll(headersParm ?? {});

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

  deleteApi(
      {required String endPoint,
      Object? body,
      void Function(int, int)? onSendProgress,
      void Function(int, int)? onReceiveProgress,
      CancelToken? cancelToken,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headersParm}) async {
    try {
      String url = "${EndPoints.baseUrl}$endPoint";
      print("URL $endPoint >> $url");
      print("GET $endPoint >> $queryParameters");
      if (await networkCheck.hasNetwork()) {
        String token = await Prefs.read(Prefs.token) ?? "";
        String selectedLangId = await Prefs.read(Prefs.selectedLangId) ?? "";

        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'language_id': selectedLangId,
          'authorization': "Bearer $token",
        };

        headers.addAll(headersParm ?? {});

        Options options = Options(headers: headers);

        print("headers : $headers");

        Response response = await dio.delete(
          url,
          options: options,
          data: body,
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
