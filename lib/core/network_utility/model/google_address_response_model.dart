class GoogleAddressResponseModel {
  GoogleAddressResponseModel({
    this.htmlAttributions,
    this.result,
    this.status,
  });

  GoogleAddressResponseModel.fromJson(dynamic json) {
    if (json['html_attributions'] != null) {
      htmlAttributions = [];
      json['html_attributions'].forEach((v) {
        // htmlAttributions?.add(Dynamic.fromJson(v));
      });
    }
    result = json['result'] != null
        ? GoogleAddressResponseModelResultResult.fromJson(json['result'])
        : null;
    status = json['status'];
  }
  List<dynamic>? htmlAttributions;
  GoogleAddressResponseModelResultResult? result;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (htmlAttributions != null) {
      map['html_attributions'] =
          htmlAttributions?.map((v) => v.toJson()).toList();
    }
    if (result != null) {
      map['result'] = result?.toJson();
    }
    map['status'] = status;
    return map;
  }
}

class GoogleAddressResponseModelResultResult {
  GoogleAddressResponseModelResultResult({
    this.addressComponents,
    this.adrAddress,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.placeId,
    this.reference,
    this.types,
    this.url,
    this.utcOffset,
    this.vicinity,
  });

  GoogleAddressResponseModelResultResult.fromJson(dynamic json) {
    if (json['address_components'] != null) {
      addressComponents = [];
      json['address_components'].forEach((v) {
        addressComponents?.add(AddressComponents.fromJson(v));
      });
    }
    adrAddress = json['adr_address'];
    formattedAddress = json['formatted_address'];
    geometry =
        json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    name = json['name'];
    placeId = json['place_id'];
    reference = json['reference'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
    url = json['url'];
    utcOffset = json['utc_offset'];
    vicinity = json['vicinity'];
  }
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  String? placeId;
  String? reference;
  List<String>? types;
  String? url;
  int? utcOffset;
  String? vicinity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (addressComponents != null) {
      map['address_components'] =
          addressComponents?.map((v) => v.toJson()).toList();
    }
    map['adr_address'] = adrAddress;
    map['formatted_address'] = formattedAddress;
    if (geometry != null) {
      map['geometry'] = geometry?.toJson();
    }
    map['icon'] = icon;
    map['icon_background_color'] = iconBackgroundColor;
    map['icon_mask_base_uri'] = iconMaskBaseUri;
    map['name'] = name;
    map['place_id'] = placeId;
    map['reference'] = reference;
    map['types'] = types;
    map['url'] = url;
    map['utc_offset'] = utcOffset;
    map['vicinity'] = vicinity;
    return map;
  }
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Geometry.fromJson(dynamic json) {
    location =
        json['location'] != null ? Location.fromJson(json['location']) : null;
    viewport =
        json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
  }
  Location? location;
  Viewport? viewport;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (location != null) {
      map['location'] = location?.toJson();
    }
    if (viewport != null) {
      map['viewport'] = viewport?.toJson();
    }
    return map;
  }
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Viewport.fromJson(dynamic json) {
    northeast = json['northeast'] != null
        ? Northeast.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? Southwest.fromJson(json['southwest'])
        : null;
  }
  Northeast? northeast;
  Southwest? southwest;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (northeast != null) {
      map['northeast'] = northeast?.toJson();
    }
    if (southwest != null) {
      map['southwest'] = southwest?.toJson();
    }
    return map;
  }
}

class Southwest {
  Southwest({
    this.lat,
    this.lng,
  });

  Southwest.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}

class Northeast {
  Northeast({
    this.lat,
    this.lng,
  });

  Northeast.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  Location.fromJson(dynamic json) {
    lat = json['lat'];
    lng = json['lng'];
  }
  double? lat;
  double? lng;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = lat;
    map['lng'] = lng;
    return map;
  }
}

class AddressComponents {
  AddressComponents({
    this.longName,
    this.shortName,
    this.types,
  });

  AddressComponents.fromJson(dynamic json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'] != null ? json['types'].cast<String>() : [];
  }
  String? longName;
  String? shortName;
  List<String>? types;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['long_name'] = longName;
    map['short_name'] = shortName;
    map['types'] = types;
    return map;
  }
}
