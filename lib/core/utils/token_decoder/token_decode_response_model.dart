class LoginTokenModel {
  LoginTokenModel({
    this.data,
    this.iat,
    this.exp,
  });

  LoginTokenModel.fromJson(dynamic json) {
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    iat = json['iat'];
    exp = json['exp'];
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
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.phone,
    this.countryCode,
    this.otp,
    this.isOtpVerified,
    this.stateId,
    this.city,
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
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  Data.fromJson(dynamic json) {
    id = json['_id'];
    roleId = json['role_id'] != null ? RoleId.fromJson(json['role_id']) : null;
    registerType = json['register_type'];
    socialKey = json['social_key'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    image = json['image'];
    email = json['email'];
    phone = json['phone'];
    countryCode = json['country_code'];
    otp = json['otp'];
    isOtpVerified = json['is_otp_verified'];
    stateId = json['state_id'];
    city = json['city'];
    languageId = json['language_id'];
    countyId =
        json['county_id'] != null ? json['county_id'].cast<String>() : [];
    categoryId =
        json['category_id'] != null ? json['category_id'].cast<String>() : [];
    documents =
        json['documents'] != null ? json['documents'].cast<String>() : [];
    documentUploaded = json['documentUploaded'] != null
        ? json['documentUploaded'].cast<String>()
        : [];
    deviceId = json['device_id'];
    deviceType = json['device_type'];
    deviceToken = json['device_token'];
    logintime = json['logintime'];
    status = json['status'];
    isapproved = json['isapproved'];
    zipCode = json['zip_code'];
    deletedAt = json['deleted_at'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
  }
  String? id;
  RoleId? roleId;
  String? registerType;
  String? socialKey;
  String? firstName;
  String? lastName;
  String? image;
  String? email;
  String? phone;
  String? countryCode;
  String? otp;
  int? isOtpVerified;
  String? stateId;
  String? city;
  String? languageId;
  List<String>? countyId;
  List<String>? categoryId;
  List<String>? documents;
  List<String>? documentUploaded;
  String? deviceId;
  String? deviceType;
  String? deviceToken;
  int? logintime;
  String? status;
  String? isapproved;
  String? zipCode;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? v;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    if (roleId != null) {
      map['role_id'] = roleId?.toJson();
    }
    map['register_type'] = registerType;
    map['social_key'] = socialKey;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['image'] = image;
    map['email'] = email;
    map['phone'] = phone;
    map['country_code'] = countryCode;
    map['otp'] = otp;
    map['is_otp_verified'] = isOtpVerified;
    map['state_id'] = stateId;
    map['city'] = city;
    map['language_id'] = languageId;
    map['county_id'] = countyId;
    map['category_id'] = categoryId;
    map['documents'] = documents;
    map['documentUploaded'] = documentUploaded;
    map['device_id'] = deviceId;
    map['device_type'] = deviceType;
    map['device_token'] = deviceToken;
    map['logintime'] = logintime;
    map['status'] = status;
    map['isapproved'] = isapproved;
    map['zip_code'] = zipCode;
    map['deleted_at'] = deletedAt;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    return map;
  }
}

class RoleId {
  RoleId({
    this.id,
    this.name,
  });

  RoleId.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
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
