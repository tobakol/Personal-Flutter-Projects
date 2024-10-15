import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/place.dart';
import '../providers/places_provider.dart';
import '../viewutils/default_scaffold.dart';
import 'add_places_screen.dart';
import 'place_details_screen.dart';

class PlacesListScreen extends ConsumerWidget {
  const PlacesListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final placeProviderService = PlacesProviderService(serviceRef: ref);
    List<Place> placeList = placeProviderService.returnList();
return DefaultScaffold(
      title: "Your Favorite Places",
      actions: [
        GestureDetector(
          child: const Icon(Icons.add_circle_outline_sharp),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPlaceScreen()));
          },
        )
      ],
      body: Column(
        children: List.generate(placeList.length, (index) {
          return buildPlaceTile(placeList[index], context);
        }),
      ),
    );
  }
  Widget buildPlaceTile(Place place, BuildContext context) {
    return ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlacesDetails(
                        chosenPlace: place!,
                      )));
        },
        title: Text(
          place.name!,
        ));
  }
}