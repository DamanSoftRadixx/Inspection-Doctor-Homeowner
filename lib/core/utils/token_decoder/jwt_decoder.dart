import 'dart:convert';
import 'dart:developer';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:inspection_doctor_homeowner/core/utils/token_decoder/token_decode_response_model.dart';

getJsonFromJWTToken({required String token}) {
  final jwt = JWT.decode(token);
  log("getJsonFromJWTToken>>> ${jsonEncode(jwt.payload)}");

  LoginTokenModel tokenData = LoginTokenModel.fromJson(jwt.payload);

  return tokenData;
}
