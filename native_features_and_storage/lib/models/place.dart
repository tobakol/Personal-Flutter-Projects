import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  final double latitude;
  final double longitude;
  final String address;
  const PlaceLocation({
    required this.address,
    required this.latitude,
    required this.longitude,
  });
}

class Place {
  String? name;
  String? id;
  File? image;
  PlaceLocation? placeLocation;
  Place({this.name, this.image, this.placeLocation, String? id // id
      })
      : id = id ?? uuid.v4();
}
//thinking of adding id by generating random string and adding
//to a list, 10 digits, if id is in list, generate another
