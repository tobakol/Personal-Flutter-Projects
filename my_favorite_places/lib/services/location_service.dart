import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:location/location.dart';

import '../models/address_details.dart';
import '../models/place.dart';
import '../viewutils/constants.dart';
import '../viewutils/view_utilities.dart';

Dio setTimeout(Dio dynDio) {
  dynDio.options.connectTimeout = const Duration(seconds: 10);
  return dynDio;
}

class LocationService {
  final setDio = setTimeout(Dio());
  static String apiKeyGooglMaps = "YOUR API KEY HERE";

  //url for getting address details
  String mapsUrl({required double latitude, required double longitude}) {
    String thisUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKeyGooglMaps";

    return thisUrl;
  }

//url for gwtting map snapshot
  String mapSnaphshotUrl({required double latitude, required double longitude}) {
    String thisUrl2 =
        """https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap
&markers=color:blue%7Clabel:S%7C$latitude,$longitude&key=$apiKeyGooglMaps""";
    return thisUrl2;
  }

  Future<Response<dynamic>?> obtainAdressDetails(
      {required String apiKey, required double latitude, required double longitude}) async {
    final response =
        await setDio.get(mapsUrl(latitude: latitude, longitude: longitude), options: ConstantsUtil.jsonOptions());
    return response;
  }

  Future<void> getAddressOperation(BuildContext context, double latitude, double longitude,
      Function(PlaceLocation placeLocation) onChooseLocation) async {
    try {
      final responseForMaps =
          await obtainAdressDetails(apiKey: apiKeyGooglMaps, latitude: latitude, longitude: longitude);
      if (responseForMaps == null) {
        return;
      } else if (responseForMaps.statusCode == 200) {
        final Map<String, dynamic> mapAddressData = responseForMaps.data;
        final addressModel = GMapsAddressDetails.fromJson(mapAddressData);
        final addressItems = addressModel.results![0];

        onChooseLocation(
            PlaceLocation(address: addressItems.formattedAddress!, latitude: latitude, longitude: longitude));
      }
    } on DioException catch (e) {
      if (context.mounted) {
        dioExceptionTasks(context, e);
      }
    }
  }

  Future<void> locationPermissionsCheck(
    Location location,
  ) async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  void dioExceptionTasks(BuildContext context, DioException e) {
    if (e.type == DioExceptionType.connectionTimeout) {
      if (context.mounted) {
        showSnackbar(context, "Request took too long");
      }
    } else {
      if (context.mounted) {
        showSnackbar(context, 'Error: ${e.response?.data ?? e.message}');
        debugPrint('Error: ${e.response?.data ?? e.message}');
      }
    }
  }
}
