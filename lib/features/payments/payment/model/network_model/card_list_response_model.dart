import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class CardListModel {
  int? status;
  bool? success;
  String? message;
  Data? data;

  CardListModel({this.status, this.success, this.message, this.data});

  CardListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'].toString().toIntConversion();
    success = (json['success'] != null && json['success'] is bool)
        ? json['success']
        : false;
    message = json['message'].toString().toStringConversion();
    data = json['data'] != null && json['data'] is Map
        ? Data.fromJson(json['data'])
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

class Data {
  String? object;
  List<CardListModelData>? data;
  bool? hasMore;
  String? url;

  Data({this.object, this.data, this.hasMore, this.url});

  Data.fromJson(Map<String, dynamic> json) {
    object = json['object'].toString().toStringConversion();
    if (json['data'] != null && json['data'] is List) {
      data = <CardListModelData>[];
      json['data'].forEach((v) {
        data!.add(CardListModelData.fromJson(v));
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
  String? dynamicLast4;
  int? expMonth;
  int? expYear;
  String? fingerprint;
  String? funding;
  String? last4;
  String? name;
  String? tokenizationMethod;
  String? wallet;

  CardListModelData(
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

  CardListModelData.fromJson(Map<String, dynamic> json) {
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

// To parse this JSON data, do
//
//     final addCardResponseModel = addCardResponseModelFromJson(jsonString);

// import 'dart:convert';

// CardListModel addCardResponseModelFromJson(String str) =>
//     CardListModel.fromJson(json.decode(str));

// String addCardResponseModelToJson(CardListModel data) =>
//     json.encode(data.toJson());

// class CardListModel {
//   int? status;
//   bool? success;
//   String? message;
//   Data? data;

//   CardListModel({
//     this.status,
//     this.success,
//     this.message,
//     this.data,
//   });

//   factory CardListModel.fromJson(Map<String, dynamic> json) => CardListModel(
//         status: json["status"],
//         success: json["success"],
//         message: json["message"],
//         data: json["data"] == null ? null : Data.fromJson(json["data"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "status": status,
//         "success": success,
//         "message": message,
//         "data": data?.toJson(),
//       };
// }

// class Data {
//   String? object;
//   List<CardListModelData>? data;
//   bool? hasMore;
//   String? url;

//   Data({
//     this.object,
//     this.data,
//     this.hasMore,
//     this.url,
//   });

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         object: json["object"],
//         data: json["data"] == null
//             ? []
//             : List<CardListModelData>.from(
//                 json["data"]!.map((x) => CardListModelData.fromJson(x))),
//         hasMore: json["has_more"],
//         url: json["url"],
//       );

//   Map<String, dynamic> toJson() => {
//         "object": object,
//         "data": data == null
//             ? []
//             : List<dynamic>.from(data!.map((x) => x.toJson())),
//         "has_more": hasMore,
//         "url": url,
//       };
// }

// class CardListModelData {
//   String? id;
//   Object? object;
//   String? addressCity;
//   Country? addressCountry;
//   String? addressLine1;
//   Check? addressLine1Check;
//   String? addressLine2;
//   String? addressState;
//   String? addressZip;
//   Check? addressZipCheck;
//   String? brand;
//   Country? country;
//   Customer? customer;
//   Check? cvcCheck;
//   dynamic dynamicLast4;
//   int? expMonth;
//   int? expYear;
//   String? fingerprint;
//   Funding? funding;
//   String? last4;
//   Metadata? metadata;
//   dynamic name;
//   dynamic tokenizationMethod;
//   dynamic wallet;

//   CardListModelData({
//     this.id,
//     this.object,
//     this.addressCity,
//     this.addressCountry,
//     this.addressLine1,
//     this.addressLine1Check,
//     this.addressLine2,
//     this.addressState,
//     this.addressZip,
//     this.addressZipCheck,
//     this.brand,
//     this.country,
//     this.customer,
//     this.cvcCheck,
//     this.dynamicLast4,
//     this.expMonth,
//     this.expYear,
//     this.fingerprint,
//     this.funding,
//     this.last4,
//     this.metadata,
//     this.name,
//     this.tokenizationMethod,
//     this.wallet,
//   });

//   factory CardListModelData.fromJson(Map<String, dynamic> json) =>
//       CardListModelData(
//         id: json["id"],
//         object: objectValues.map[json["object"]]!,
//         addressCity: json["address_city"],
//         addressCountry: countryValues.map[json["address_country"]]!,
//         addressLine1: json["address_line1"],
//         addressLine1Check: checkValues.map[json["address_line1_check"]]!,
//         addressLine2: json["address_line2"],
//         addressState: json["address_state"],
//         addressZip: json["address_zip"],
//         addressZipCheck: checkValues.map[json["address_zip_check"]]!,
//         brand: json["brand"],
//         country: countryValues.map[json["country"]]!,
//         customer: customerValues.map[json["customer"]]!,
//         cvcCheck: checkValues.map[json["cvc_check"]]!,
//         dynamicLast4: json["dynamic_last4"],
//         expMonth: json["exp_month"],
//         expYear: json["exp_year"],
//         fingerprint: json["fingerprint"],
//         funding: fundingValues.map[json["funding"]]!,
//         last4: json["last4"],
//         metadata: json["metadata"] == null
//             ? null
//             : Metadata.fromJson(json["metadata"]),
//         name: json["name"],
//         tokenizationMethod: json["tokenization_method"],
//         wallet: json["wallet"],
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "object": objectValues.reverse[object],
//         "address_city": addressCity,
//         "address_country": countryValues.reverse[addressCountry],
//         "address_line1": addressLine1,
//         "address_line1_check": checkValues.reverse[addressLine1Check],
//         "address_line2": addressLine2,
//         "address_state": addressState,
//         "address_zip": addressZip,
//         "address_zip_check": checkValues.reverse[addressZipCheck],
//         "brand": brand,
//         "country": countryValues.reverse[country],
//         "customer": customerValues.reverse[customer],
//         "cvc_check": checkValues.reverse[cvcCheck],
//         "dynamic_last4": dynamicLast4,
//         "exp_month": expMonth,
//         "exp_year": expYear,
//         "fingerprint": fingerprint,
//         "funding": fundingValues.reverse[funding],
//         "last4": last4,
//         "metadata": metadata?.toJson(),
//         "name": name,
//         "tokenization_method": tokenizationMethod,
//         "wallet": wallet,
//       };
// }

// enum Country { CN, JP, US }

// final countryValues =
//     EnumValues({"CN": Country.CN, "JP": Country.JP, "US": Country.US});

// enum Check { PASS }

// final checkValues = EnumValues({"pass": Check.PASS});

// enum Customer { CUS_ODO_T_GR_T_OE_UTI_T5 }

// final customerValues =
//     EnumValues({"cus_OdoTGrTOeUtiT5": Customer.CUS_ODO_T_GR_T_OE_UTI_T5});

// enum Funding { CREDIT }

// final fundingValues = EnumValues({"credit": Funding.CREDIT});

// class Metadata {
//   Metadata();

//   factory Metadata.fromJson(Map<String, dynamic> json) => Metadata();

//   Map<String, dynamic> toJson() => {};
// }

// enum Object { CARD }

// final objectValues = EnumValues({"card": Object.CARD});

// class EnumValues<T> {
//   Map<String, T> map;
//   late Map<T, String> reverseMap;

//   EnumValues(this.map);

//   Map<T, String> get reverse {
//     reverseMap = map.map((k, v) => MapEntry(v, k));
//     return reverseMap;
//   }
// }
