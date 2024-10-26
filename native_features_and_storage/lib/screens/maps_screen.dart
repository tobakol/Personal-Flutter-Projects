import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:native_features_and_storage/models/place.dart';
import 'package:native_features_and_storage/viewutils/default_scaffold.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen(
      {super.key,
      this.placeLocation = const PlaceLocation(latitude: 37.422, longitude: -122.084, address: ""),
      this.isSelecting = true});
  final PlaceLocation placeLocation;
  final bool isSelecting;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedPosition;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isSelecting == false) {
      _pickedPosition = LatLng(widget.placeLocation.latitude, widget.placeLocation.longitude);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: widget.isSelecting ? "Pick your location" : "Your location",
      actions: [
        if (widget.isSelecting)
          IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedPosition);
              },
              icon: Icon(Icons.save))
      ],
      body: GoogleMap(
        onTap: widget.isSelecting == false
            ? null
            : (position) {
                setState(() {
                  _pickedPosition = position;
                });
              },
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.placeLocation.latitude, widget.placeLocation.longitude),
          zoom: 16,
        ),
        markers: (_pickedPosition == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId("Place"),
                  position:
                      _pickedPosition!, //?? LatLng(widget.placeLocation.latitude, widget.placeLocation.longitude),
                )
              },
      ),
    );
  }
}
