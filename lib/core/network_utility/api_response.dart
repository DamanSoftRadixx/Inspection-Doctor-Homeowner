import 'package:dio/dio.dart';

class ApiResponse {
  final int statusCode;
  final String statusMessage;
  final Response response;
  ApiResponse({
    required this.statusMessage,
    required this.response,
    required this.statusCode,
  });
}
