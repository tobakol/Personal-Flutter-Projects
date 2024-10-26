class GMapsAddressDetails {
  List<ResultItem>? results;

  GMapsAddressDetails({this.results});

  GMapsAddressDetails.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <ResultItem>[];
      json['results'].forEach((v) {
        results!.add(ResultItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ResultItem {
  List<AddressComponents>? addressComponents;
  String? formattedAddress;
  Geometry? geometry;
  String? placeId;
  List<String>? types;

  ResultItem({this.addressComponents, this.formattedAddress, this.geometry, this.placeId, this.types});

  ResultItem.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(AddressComponents.fromJson(v));
      });
    }
    formattedAddress = json['formatted_address'];
    geometry = json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
    placeId = json['place_id'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (addressComponents != null) {
      data['address_components'] = addressComponents!.map((v) => v.toJson()).toList();
    }
    data['formatted_address'] = formattedAddress;
    if (geometry != null) {
      data['geometry'] = geometry!.toJson();
    }
    data['place_id'] = placeId;
    data['types'] = types;
    return data;
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['long_name'] = longName;
    data['short_name'] = shortName;
    data['types'] = types;
    return data;
  }
}

class Geometry {
  LocationCordinates? location;
  String? locationType;
  ViewportCordinates? viewport;

  Geometry({this.location, this.locationType, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null ? LocationCordinates.fromJson(json['location']) : null;
    locationType = json['location_type'];
    viewport = json['viewport'] != null ? ViewportCordinates.fromJson(json['viewport']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['location_type'] = locationType;
    if (viewport != null) {
      data['viewport'] = viewport!.toJson();
    }
    return data;
  }
}

class LocationCordinates {
  double? lat;
  double? lng;

  LocationCordinates({this.lat, this.lng});

  LocationCordinates.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class ViewportCordinates {
  LocationCordinates? northeast;
  LocationCordinates? southwest;

  ViewportCordinates({this.northeast, this.southwest});

  ViewportCordinates.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null ? LocationCordinates.fromJson(json['northeast']) : null;
    southwest = json['southwest'] != null ? LocationCordinates.fromJson(json['southwest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (northeast != null) {
      data['northeast'] = northeast!.toJson();
    }
    if (southwest != null) {
      data['southwest'] = southwest!.toJson();
    }
    return data;
  }
}
