import 'package:inspection_doctor_homeowner/core/extensions/string_extensions.dart';

class TokenResponseModel {
  TokenResponseModel({
    this.data,
    this.iat,
    this.exp,
  });

  TokenResponseModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    iat = json['iat'].toString().toIntConversion();
    exp = json['exp'].toString().toIntConversion();
  }
  Data? data;
  int? iat;
  int? exp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (data != null) {
      map['data'] = data?.toJson();
    }
    map['iat'] = iat;
    map['exp'] = exp;
    return map;
  }
}

class Data {
  Data({
    this.id,
    this.roleId,
    this.registerType,
    this.socialKey,
    this.companyName,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.phone,
    this.countryCode,
    this.otp,
    this.isOtpVerified,
    this.createdByUserId,
    this.state,
    this.city,
    this.drivingLicenceNumber,
    this.drivingLicenceIssuedState,
    this.availabilities,
    this.rejectedReason,
    this.languageId,
    this.countyId,
    this.categoryId,
    this.documents,
    this.documentUploaded,
    this.deviceId,
    this.deviceType,
    this.deviceToken,
    this.logintime,
    this.status,
    this.isapproved,
    this.zipCode,
    this.addressLine1,
    this.addressLine2,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    roleId = json['role_id'] != null ? RoleId.fromJson(json['role_id']) : null;
    registerType = json['register_type'].toString().toStringConversion();
    socialKey = json['social_key'].toString().toStringConversion();
    companyName = json['company_name'].toString().toStringConversion();
    firstName = json['first_name'].toString().toStringConversion();
    lastName = json['last_name'].toString().toStringConversion();
    image = json['image'] != null ? Image.fromJson(json['image']) : null;
    email = json['email'].toString().toStringConversion();
    phone = json['phone'].toString().toStringConversion();
    countryCode = json['country_code'].toString().toStringConversion();
    otp = json['otp'].toString().toStringConversion();
    isOtpVerified = json['is_otp_verified'];
    createdByUserId = json['created_by_user_id'].toString().toStringConversion();

    if(json['state'] is String){
      state = State(name: json['state'].toString().toStringConversion());
    }else{
      state = json['state'] != null ? State.fromJson(json['state']) : null;
    }

    city = json['city'].toString().toStringConversion();
    drivingLicenceNumber = json['driving_licence_number'].toString().toStringConversion();
    drivingLicenceIssuedState = json['driving_licence_issued_state'] != null
        ? DrivingLicenceIssuedState.fromJson(
            json['driving_licence_issued_state'])
        : null;
    availabilities = json['availabilities'];
    rejectedReason = json['rejected_reason'].toString().toStringConversion();
    languageId = json['language_id'].toString().toStringConversion();
    if (json['county_id'] != null) {
      countyId = [];
      json['county_id'].forEach((v) {
        // countyId?.add(CountyId.fromJson(v));
      });
    }
    if (json['category_id'] != null) {
      categoryId = [];
      json['category_id'].forEach((v) {
        // categoryId?.add(Dynamic.fromJson(v));
      });
    }
    if (json['documents'] != null) {
      documents = [];
      json['documents'].forEach((v) {
        // documents?.add(Dynamic.fromJson(v));
      });
    }
    if (json['documentUploaded'] != null) {
      documentUploaded = [];
      json['documentUploaded'].forEach((v) {
        // documentUploaded?.add(Dynamic.fromJson(v));
      });
    }
    deviceId = json['device_id'].toString().toStringConversion();
    deviceType = json['device_type'].toString().toStringConversion();
    deviceToken = json['device_token'].toString().toStringConversion();
    logintime = json['logintime'].toString().toIntConversion();
    status = json['status'].toString().toStringConversion();
    isapproved = json['isapproved'];
    zipCode = json['zip_code'].toString().toStringConversion();
    addressLine1 = json['address_line_1'].toString().toStringConversion();
    addressLine2 = json['address_line_2'].toString().toStringConversion();
    deletedAt = json['deleted_at'].toString().toStringConversion();
    createdAt = json['createdAt'].toString().toStringConversion();
    updatedAt = json['updatedAt'].toString().toStringConversion();
    v = json['__v'].toString().toStringConversion();
  }
  String? id;
  RoleId? roleId;
  String? registerType;
  dynamic socialKey;
  dynamic companyName;
  String? firstName;
  String? lastName;
  Image? image;
  String? email;
  String? phone;
  String? countryCode;
  String? otp;
  int? isOtpVerified;
  String? createdByUserId;
  State? state;
  String? city;
  dynamic drivingLicenceNumber;
  DrivingLicenceIssuedState? drivingLicenceIssuedState;
  bool? availabilities;
  dynamic rejectedReason;
  dynamic languageId;
  List<dynamic>? countyId;
  List<dynamic>? categoryId;
  List<dynamic>? documents;
  List<dynamic>? documentUploaded;
  String? deviceId;
  String? deviceType;
  String? deviceToken;
  int? logintime;
  String? status;
  String? isapproved;
  String? zipCode;
  String? addressLine1;
  String? addressLine2;
  dynamic deletedAt;
  String? createdAt;
  String? updatedAt;
  dynamic v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (roleId != null) {
      map['role_id'] = roleId?.toJson();
    }
    map['register_type'] = registerType;
    map['social_key'] = socialKey;
    map['company_name'] = companyName;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    if (image != null) {
      map['image'] = image?.toJson();
    }
    map['email'] = email;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    map['otp'] = otp;
    map['is_otp_verified'] = isOtpVerified;
    map['created_by_user_id'] = createdByUserId;
    if (state != null) {
      map['state'] = state?.toJson();
    }
    map['city'] = city;
    map['driving_licence_number'] = drivingLicenceNumber;
    if (drivingLicenceIssuedState != null) {
      map['driving_licence_issued_state'] = drivingLicenceIssuedState?.toJson();
    }
    map['availabilities'] = availabilities;
    map['rejected_reason'] = rejectedReason;
    map['language_id'] = languageId;
    if (countyId != null) {
      map['county_id'] = countyId?.map((v) => v.toJson()).toList();
    }
    if (categoryId != null) {
      map['category_id'] = categoryId?.map((v) => v.toJson()).toList();
    }
    if (documents != null) {
      map['documents'] = documents?.map((v) => v.toJson()).toList();
    }
    if (documentUploaded != null) {
      map['documentUploaded'] =
          documentUploaded?.map((v) => v.toJson()).toList();
    }
    map['device_id'] = deviceId;
    map['device_type'] = deviceType;
    map['device_token'] = deviceToken;
    map['logintime'] = logintime;
    map['status'] = status;
    map['isapproved'] = isapproved;
    map['zip_code'] = zipCode;
    map['address_line_1'] = addressLine1;
    map['address_line_2'] = addressLine2;
    map['deleted_at'] = deletedAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class DrivingLicenceIssuedState {
  DrivingLicenceIssuedState({
    this.id,
    this.name,
  });

  DrivingLicenceIssuedState.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }
}

class State {
  State({
    this.id,
    this.name,
  });

  State.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }
}

class Image {
  Image({
    this.id,
    this.url,
  });

  Image.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    url = json['url'].toString().toStringConversion();
  }
  String? id;
  String? url;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['url'] = url;
    return map;
  }
}

class RoleId {
  RoleId({
    this.id,
    this.name,
  });

  RoleId.fromJson(dynamic json) {
    id = json['_id'].toString().toStringConversion();
    name = json['name'].toString().toStringConversion();
  }
  String? id;
  String? name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['name'] = name;
    return map;
  }
}
