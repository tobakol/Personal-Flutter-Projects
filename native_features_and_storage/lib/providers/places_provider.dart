import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../models/place.dart';

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);
  void editPlacesList(Place place) {
    final placesInList = state.contains(place);

    if (placesInList) {
      state = state.where((m) => m.id != place.id).toList();
    } else {
      state = [...state, place];
    }
  }
}

final placeProvider = StateNotifierProvider<PlacesNotifier, List<Place>>((ref) {
  return PlacesNotifier();
});

class PlacesProviderService {
  WidgetRef serviceRef;
  PlacesProviderService({required this.serviceRef});

  List<Place> returnList() {
    final placeList = serviceRef.watch(placeProvider);
    return placeList;
  }

  void editPlaceList(Place place) {
    serviceRef.read(placeProvider.notifier).editPlacesList(place);
  }
}
