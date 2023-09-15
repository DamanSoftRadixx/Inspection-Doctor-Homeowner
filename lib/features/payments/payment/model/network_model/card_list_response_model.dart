// import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

// class CardListModel {
//   int? status;
//   bool? success;
//   String? message;
//   CardListModelData? data;
//   CardListModel({this.status, this.success, this.message, this.data});
//   CardListModel.fromJson(Map<String, dynamic> json) {
//     status = json['status'].toString().toIntConversion();
//     success = json['success'];
//     message = json['message'].toString().toStringConversion();
//     data = json['data'] != null && json['data'] is Map
//         ? CardListModelData.fromJson(json['data'])
//         : null;
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['status'] = status;
//     data['success'] = success;
//     data['message'] = message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class CardListModelData {
//   String? object;
//   List<String>? data;
//   bool? hasMore;
//   String? url;
//   CardListModelData({this.object, this.data, this.hasMore, this.url});
//   CardListModelData.fromJson(Map<String, dynamic> json) {
//     object = json['object'].toString().toStringConversion();
//     data = json['data'].cast<String>();
//     hasMore = json['has_more'];
//     url = json['url'].toString().toStringConversion();
//   }
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['object'] = object;
//     data['data'] = this.data;
//     data['has_more'] = hasMore;
//     data['url'] = url;
//     return data;
//   }
// }
// To parse this JSON data, do
//
//     final countyResponseModel = countyResponseModelFromJson(jsonString);
// To parse this JSON data, do
//
//     final cardResponseModel = cardResponseModelFromJson(jsonString);

import 'dart:convert';

CardListModel cardResponseModelFromJson(String str) =>
    CardListModel.fromJson(json.decode(str));

String cardResponseModelToJson(CardListModel data) =>
    json.encode(data.toJson());

class CardListModel {
  int? status;
  bool? success;
  String? message;
  Data? data;

  CardListModel({
    this.status,
    this.success,
    this.message,
    this.data,
  });

  factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  String? object;
  List<CardListModelData>? data;
  bool? hasMore;
  String? url;

  Data({
    this.object,
    this.data,
    this.hasMore,
    this.url,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        object: json["object"],
        data: json["data"] == null
            ? []
            : List<CardListModelData>.from(
                json["data"]!.map((x) => CardListModelData.fromJson(x))),
        hasMore: json["has_more"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "object": object,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "has_more": hasMore,
        "url": url,
      };
}

class CardListModelData {
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
  dynamic dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  Metadata? metadata;
  dynamic name;
  dynamic tokenizationMethod;
  dynamic wallet;

  CardListModelData({
    this.id,
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
    this.metadata,
    this.name,
    this.tokenizationMethod,
    this.wallet,
  });

  factory CardListModelData.fromJson(Map<String, dynamic> json) =>
      CardListModelData(
        id: json["id"],
        object: json["object"],
        addressCity: json["address_city"],
        addressCountry: json["address_country"],
        addressLine1: json["address_line1"],
        addressLine1Check: json["address_line1_check"],
        addressLine2: json["address_line2"],
        addressState: json["address_state"],
        addressZip: json["address_zip"],
        addressZipCheck: json["address_zip_check"],
        brand: json["brand"],
        country: json["country"],
        customer: json["customer"],
        cvcCheck: json["cvc_check"],
        dynamicLast4: json["dynamic_last4"],
        expMonth: json["exp_month"],
        expYear: json["exp_year"],
        fingerprint: json["fingerprint"],
        funding: json["funding"],
        last4: json["last4"],
        metadata: json["metadata"] == null
            ? null
            : Metadata.fromJson(json["metadata"]),
        name: json["name"],
        tokenizationMethod: json["tokenization_method"],
        wallet: json["wallet"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "object": object,
        "address_city": addressCity,
        "address_country": addressCountry,
        "address_line1": addressLine1,
        "address_line1_check": addressLine1Check,
        "address_line2": addressLine2,
        "address_state": addressState,
        "address_zip": addressZip,
        "address_zip_check": addressZipCheck,
        "brand": brand,
        "country": country,
        "customer": customer,
        "cvc_check": cvcCheck,
        "dynamic_last4": dynamicLast4,
        "exp_month": expMonth,
        "exp_year": expYear,
        "fingerprint": fingerprint,
        "funding": funding,
        "last4": last4,
        "metadata": metadata?.toJson(),
        "name": name,
        "tokenization_method": tokenizationMethod,
        "wallet": wallet,
      };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

  Map<String, dynamic> toJson() => {};
}
