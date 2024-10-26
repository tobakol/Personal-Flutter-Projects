import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_features_and_storage/viewutils/widgets_extensions.dart';
import '../models/place.dart';
import '../providers/places_provider.dart';
import '../viewutils/default_scaffold.dart';
import 'add_places_screen.dart';
import 'place_details_screen.dart';

class PlacesListScreen extends ConsumerStatefulWidget {
  const PlacesListScreen({super.key});
  @override
  ConsumerState<PlacesListScreen> createState() => _PlacesListScreenState();
}

class _PlacesListScreenState extends ConsumerState<PlacesListScreen> {
  bool busy = false;
  //final placesProviderService =
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      busy = true;
    });
    PlacesProviderService(serviceRef: ref).returnStoredList();
    setState(() {
      busy = false;
    });
  }

  @override
  Widget build(
    BuildContext context,
  ) {
    final placeProviderService = PlacesProviderService(serviceRef: ref);
    List<Place> placeList = placeProviderService.returnList();
    return DefaultScaffold(
      busy: busy,
      title: "Your Favorite Places",
      actions: [
        GestureDetector(
          child: const Icon(Icons.add_circle_outline_sharp),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => const AddPlaceScreen()));
          },
        ).spaceTo(right: 20)
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
                      chosenPlace: place,
                    )));
      },
      leading: CircleAvatar(
        backgroundImage: FileImage(place.image!),
      ),
      title: Text(
        place.name!,
      ),
      subtitle: Text(place.placeLocation!.address),
    );
  }
}
