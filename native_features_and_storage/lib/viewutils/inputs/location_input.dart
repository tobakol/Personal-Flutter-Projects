import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:native_features_and_storage/models/address_details.dart';
import 'package:native_features_and_storage/models/place.dart';
import 'package:native_features_and_storage/screens/maps_screen.dart';
import 'package:native_features_and_storage/services/location_service.dart';
import 'package:native_features_and_storage/viewutils/constants.dart';
import 'package:native_features_and_storage/viewutils/view_utilities.dart';
import 'package:native_features_and_storage/viewutils/widgets_extensions.dart';

class LocationInput extends StatefulWidget {
  final Function(PlaceLocation placeLocation) onChooseLocation;
  const LocationInput({super.key, required this.onChooseLocation});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  LocationData? gottenLocationData;
  bool _isGettingLocation = false;
  Location location = Location();
  LatLng? imageLatLang;
  void getCurrentLocation() async {
    LocationData locationData;
    await LocationService().locationPermissionsCheck(location);

    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    setState(() {
      gottenLocationData = locationData;
      imageLatLang = LatLng(locationData.latitude!, locationData.longitude!);
    });
    await LocationService()
        .getAddressOperation(context, locationData.latitude!, locationData.longitude!, widget.onChooseLocation);
    setState(() {
      _isGettingLocation = false;
    });
    // try {
    //   // setState(() {
    //   //   _isGettingLocation = true;
    //   // });
    //   final responseForMaps = await LocationService().obtainAdressDetails(
    //       apiKey: ConstantsUtil.api_key_google_maps,
    //       latitude: locationData.latitude!,
    //       longitude: locationData.longitude!);
    //   if (responseForMaps == null) {
    //     setState(() {
    //       _isGettingLocation = false;
    //     });
    //     return;
    //   } else if (responseForMaps.statusCode == 200) {
    //     //debugPrint(responseForMaps.data.toString());
    //     final Map<String, dynamic> mapAddressData = responseForMaps.data;
    //     final addressModel = GMapsAddressDetails.fromJson(mapAddressData);
    //     final addressItems = addressModel.results![0];
    //     setState(() {
    //       _isGettingLocation = false;
    //       widget.onChooseLocation(PlaceLocation(
    //           address: addressItems.formattedAddress!,
    //           latitude: locationData.latitude!,
    //           longitude: locationData.longitude!));
    //     });
    //   }
    // } on DioException catch (e) {
    //   LocationService().dioExceptionTasks(context, e);
    //   setState(() {
    //     _isGettingLocation = false;
    //   });
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.purple)),
          height: _isGettingLocation ? 250 : null,
          //  width: double.infinity,
          alignment: // imageFile == null ?
              Alignment.center //: null,
          ,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (imageLatLang != null)
                SizedBox(
                  height: 200,
                  child: Image.network(ConstantsUtil.mapSnaphshotUrl(
                      latitude: imageLatLang!.latitude!, longitude: imageLatLang!.longitude!)),
                ).spaceTo(bottom: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(onTap: getCurrentLocation, child: const Icon(Icons.my_location_rounded)),
                  GestureDetector(
                    onTap: () async {
                      final newPickedLocation = await Navigator.of(context)
                          .push<LatLng>(MaterialPageRoute(builder: (context) => MapsScreen()));
                      //  takePictute(viaCamera: false);

                      if (newPickedLocation == null) {
                        return;
                      }
                      debugPrint(newPickedLocation.latitude.toString());
                      debugPrint(newPickedLocation.longitude.toString());
                      setState(() {
                        _isGettingLocation = true;
                      });
                      final cart = await LocationService().getAddressOperation(
                          context, newPickedLocation.latitude, newPickedLocation.longitude, widget.onChooseLocation);
                      setState(() {
                        _isGettingLocation = false;
                        imageLatLang = newPickedLocation;
                      });
                    },
                    child: const Icon(Icons.location_on),
                  ),
                ],
              ),
            ],
          ),
        ),
        if (_isGettingLocation)
          Container(
            // height: double.maxFinite,
            // width: double.maxFinite,
            height: 250,
            color: Colors.grey.withOpacity(0.3),
            alignment: Alignment.center,
            child: loader,
          )
      ],
    );
  }
}
