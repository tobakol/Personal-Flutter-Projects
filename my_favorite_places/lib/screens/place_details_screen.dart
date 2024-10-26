import 'package:flutter/material.dart';
import 'package:my_favorite_places/viewutils/widgets_extensions.dart';

import '../models/place.dart';
import '../services/location_service.dart';
import '../viewutils/default_scaffold.dart';
import 'maps_screen.dart';

class PlacesDetails extends StatefulWidget {
  final Place chosenPlace;
  const PlacesDetails({super.key, required this.chosenPlace});

  @override
  State<PlacesDetails> createState() => _PlacesDetailsState();
}

class _PlacesDetailsState extends State<PlacesDetails> {
  @override
  Widget build(BuildContext context) {
    return DefaultScaffold(
      title: widget.chosenPlace.name,
      body: Container(
        alignment: Alignment.center,
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.file(
              widget.chosenPlace.image!,
              fit: BoxFit.cover,
              // width: double.infinity,
              // height: double.infinity,
            ).spaceTo(bottom: 8),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MapsScreen(
                                  placeLocation: widget.chosenPlace.placeLocation!,
                                  isSelecting: false,
                                )));
                      },
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(LocationService().mapSnaphshotUrl(
                            latitude: widget.chosenPlace.placeLocation!.latitude,
                            longitude: widget.chosenPlace.placeLocation!.longitude)),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(color: Colors.black),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        widget.chosenPlace.placeLocation!.address,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                )),
            Text(
              widget.chosenPlace.name!,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
