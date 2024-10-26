import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ConstantsUtil {
  static String api_key_google_maps = "AIzaSyDM9Fw0QJmjslkldE_O8hNN1KghcRztrvs";

  //url for getting address details
  static String mapsUrl({required double latitude, required double longitude}) {
    // String thisUrl = "https://maps.googleapis.com/maps/api/geocode/json?latlng=4$latitude,$longitude&key=$apiKey";
    String thisUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$api_key_google_maps";

    return thisUrl;
  }

//url for gwtting map snapshot
  static String mapSnaphshotUrl({required double latitude, required double longitude}) {
    String thisUrl2 =
        """https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap
&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$api_key_google_maps""";
    return thisUrl2;
  }

  static Options jsonOptions() {
    return Options(
      headers: {
        'Content-Type': 'application/json',
      },
    );
  }

  static String dataBaseName = 'stored_places';
}
