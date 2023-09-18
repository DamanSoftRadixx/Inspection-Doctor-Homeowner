import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class AddCardResponseModel {
  int? status;
  bool? success;
  String? message;
  AddCardResponseModelData? data;

  AddCardResponseModel({this.status, this.success, this.message, this.data});

  AddCardResponseModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString().toIntConversion();
    success = (json['success'] != null && json['success'] is bool)
        ? json['success']
        : false;
    message = json['message'].toString().toStringConversion();
    data = json['data'] != null && json['data'] is Map
        ? AddCardResponseModelData.fromJson(json['data'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['success'] = success;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class AddCardResponseModelData {
  String? object;
  List<AddCardResponseModelData>? data;
  bool? hasMore;
  String? url;

  AddCardResponseModelData({this.object, this.data, this.hasMore, this.url});

  AddCardResponseModelData.fromJson(Map<String, dynamic> json) {
    object = json['object'].toString().toStringConversion();
    if (json['data'] != null && json['data'] is List) {
      data = <AddCardResponseModelData>[];
      json['data'].forEach((v) {
        if (json['v'] is Map) {
          data!.add(AddCardResponseModelData.fromJson(v));
        }
      });
    }
    hasMore = (json['has_more'] != null && json['has_more'] is bool)
        ? json['has_more']
        : false;
    url = json['url'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['object'] = object;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['has_more'] = hasMore;
    data['url'] = url;
    return data;
  }
}

class Data {
  String? id;
  String? object;
  String? addressCity;
  String? addressCountry;
  String? addressLine1;
  String? addressLine1Check;
  String? addressLine2;
  String? addressState;
  String? addressZip;
  String? addressZipCheck;
  String? brand;
  String? country;
  String? customer;
  String? cvcCheck;
  String? dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  String? name;
  String? tokenizationMethod;
  String? wallet;

  Data(
      {this.id,
      this.object,
      this.addressCity,
      this.addressCountry,
      this.addressLine1,
      this.addressLine1Check,
      this.addressLine2,
      this.addressState,
      this.addressZip,
      this.addressZipCheck,
      this.brand,
      this.country,
      this.customer,
      this.cvcCheck,
      this.dynamicLast4,
      this.expMonth,
      this.expYear,
      this.fingerprint,
      this.funding,
      this.last4,
      this.name,
      this.tokenizationMethod,
      this.wallet});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString().toStringConversion();
    object = json['object'].toString().toStringConversion();
    addressCity = json['address_city'].toString().toStringConversion();
    addressCountry = json['address_country'].toString().toStringConversion();
    addressLine1 = json['address_line1'].toString().toStringConversion();
    addressLine1Check =
        json['address_line1_check'].toString().toStringConversion();
    addressLine2 = json['address_line2'].toString().toStringConversion();
    addressState = json['address_state'].toString().toStringConversion();
    addressZip = json['address_zip'].toString().toStringConversion();
    addressZipCheck = json['address_zip_check'].toString().toStringConversion();
    brand = json['brand'].toString().toStringConversion();
    country = json['country'].toString().toStringConversion();
    customer = json['customer'].toString().toStringConversion();
    cvcCheck = json['cvc_check'].toString().toStringConversion();
    dynamicLast4 = json['dynamic_last4'].toString().toStringConversion();
    expMonth = json['exp_month'].toString().toIntConversion();
    expYear = json['exp_year'].toString().toIntConversion();
    fingerprint = json['fingerprint'].toString().toStringConversion();
    funding = json['funding'].toString().toStringConversion();
    last4 = json['last4'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();
    tokenizationMethod =
        json['tokenization_method'].toString().toStringConversion();
    wallet = json['wallet'].toString().toStringConversion();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['object'] = object;
    data['address_city'] = addressCity;
    data['address_country'] = addressCountry;
    data['address_line1'] = addressLine1;
    data['address_line1_check'] = addressLine1Check;
    data['address_line2'] = addressLine2;
    data['address_state'] = addressState;
    data['address_zip'] = addressZip;
    data['address_zip_check'] = addressZipCheck;
    data['brand'] = brand;
    data['country'] = country;
    data['customer'] = customer;
    data['cvc_check'] = cvcCheck;
    data['dynamic_last4'] = dynamicLast4;
    data['exp_month'] = expMonth;
    data['exp_year'] = expYear;
    data['fingerprint'] = fingerprint;
    data['funding'] = funding;
    data['last4'] = last4;
    data['name'] = name;
    data['tokenization_method'] = tokenizationMethod;
    data['wallet'] = wallet;
    return data;
  }
}
