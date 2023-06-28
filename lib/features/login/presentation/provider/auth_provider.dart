import 'dart:developer';

import 'package:inspection_doctor_homeowner/features/login/presentation/models/network_model/otp_verification_model.dart';
import 'package:inspection_doctor_homeowner/features/signup/presentation/models/city_listing_response.dart';
import 'package:inspection_doctor_homeowner/features/signup/presentation/models/country_listing_response.dart';
import 'package:inspection_doctor_homeowner/features/signup/presentation/models/state_listing_response.dart';

import '../../../../core/common_ui/app_end_points.dart';
import '../../../../core/network_utility/api_hitter.dart';
import '../../../signup/presentation/models/signup_model.dart';
import '../models/network_model/login_model.dart';

class AuthProvider {
  Future<SignupResponse?> signupRequest(
      {required Map<String, dynamic> body}) async {
    try {
      var response = await ApiHitter.shared
          .postApi(endPoint: EndPoints.register, body: body);
      return SignupResponse.fromJson(response.body);
    } catch (e) {
      log("Error>> ${e.toString()}");
    }
    return null;
  }

  Future<CountryListingResponse?> getCountryListing() async {
    try {
      var response =
          await ApiHitter.shared.getApi(endPoint: EndPoints.countryListing);
      return CountryListingResponse.fromJson(response.body);
    } catch (e) {
      log("Error>> ${e.toString()}");
    }
    return null;
  }

  Future<StateListingResponse?> getStateListing(String countryId) async {
    try {
      var response = await ApiHitter.shared
          .getApi(endPoint: "${EndPoints.stateListing}/$countryId");
      return StateListingResponse.fromJson(response.body);
    } catch (e) {
      log("Error>> ${e.toString()}");
    }
    return null;
  }

  Future<CityListingResponse?> getCityListing(
      String countryId, String stateId) async {
    try {
      var response = await ApiHitter.shared.getApi(
          endPoint:
              "${EndPoints.cityListing}?country_id=$countryId&state_id=$stateId");
      return CityListingResponse.fromJson(response.body);
    } catch (e) {
      log("Error>> ${e.toString()}");
    }
    return null;
  }

  Future<Login?> loginRequest({required Map<String, dynamic> body}) async {
    try {
      var response =
          await ApiHitter.shared.postApi(endPoint: EndPoints.login, body: body);
      return Login.fromJson(response.body);
    } catch (e) {
      log("Error>> ${e.toString()}");
    }
    return null;
  }

  Future<OtpVerificationModel?> mailVerificationRequest(
      {required Map<String, dynamic> body}) async {
    try {
      var response = await ApiHitter.shared
          .postApi(endPoint: EndPoints.mailVerification, body: body);
      return OtpVerificationModel.fromJson(response.body);
    } catch (e) {
      log("Error>> ${e.toString()}");
    }
    return null;
  }

  Future<OtpVerificationModel?> resendOTPRequest(
      {required Map<String, dynamic> body}) async {
    try {
      var response = await ApiHitter.shared
          .postApi(endPoint: EndPoints.resendEmailOtp, body: body);
      return OtpVerificationModel.fromJson(response.body);
    } catch (e) {
      log("Error>> ${e.toString()}");
    }
    return null;
  }
}
