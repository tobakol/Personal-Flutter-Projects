import 'package:flutter/material.dart';

import '../models/place.dart';
import '../viewutils/default_scaffold.dart';

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
      title: "Details",
      body: Center(child: Text(widget.chosenPlace.name!, style: TextStyle(color: Colors.white),)),
    );
  }
}
