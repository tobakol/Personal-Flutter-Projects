import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:my_favorite_places/viewutils/widgets_extensions.dart';

import '../../models/place.dart';
import '../../screens/maps_screen.dart';
import '../../services/location_service.dart';
import '../view_utilities.dart';

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
  final locationService = LocationService();
  void getCurrentLocation() async {
    LocationData locationData;
    await locationService.locationPermissionsCheck(location);

    setState(() {
      _isGettingLocation = true;
    });
    locationData = await location.getLocation();
    setState(() {
      gottenLocationData = locationData;
      imageLatLang = LatLng(locationData.latitude!, locationData.longitude!);
    });
    await locationService.getAddressOperation(
        context, locationData.latitude!, locationData.longitude!, widget.onChooseLocation);
    setState(() {
      _isGettingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.purple)),
          height: _isGettingLocation ? 250 : null,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              if (imageLatLang != null)
                SizedBox(
                  height: 220,
                  child: Image.network(locationService.mapSnaphshotUrl(
                      latitude: imageLatLang!.latitude, longitude: imageLatLang!.longitude)),
                ).spaceTo(bottom: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(onTap: getCurrentLocation, child: const Icon(Icons.my_location_rounded)),
                  GestureDetector(
                    onTap: () async {
                      final newPickedLocation = await Navigator.of(context)
                          .push<LatLng>(MaterialPageRoute(builder: (context) => const MapsScreen()));

                      if (newPickedLocation == null) {
                        return;
                      }
                      debugPrint(newPickedLocation.latitude.toString());
                      debugPrint(newPickedLocation.longitude.toString());
                      setState(() {
                        _isGettingLocation = true;
                      });
                      await locationService.getAddressOperation(
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
