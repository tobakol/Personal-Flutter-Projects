import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_features_and_storage/viewutils/constants.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as sys_paths;
import 'package:sqflite/sqflite.dart' as sqfl;
import 'package:sqflite/sqlite_api.dart';

import '../models/place.dart';

Future<Database> _getDataBase() async {
  final dbPath = await sqfl.getDatabasesPath();
  final db = await sqfl.openDatabase(path.join(dbPath, 'places.db'), //dbcreated using joined paths
      onCreate: (db, version) {
    //oncreate configures db like initstaate i guess or even build
    return db.execute(
        "CREATE TABLE $_dbName(id TEXT PRIMARY KEY, name TEXT, imagepath TEXT, lat REAL, lng REAL, address TEXT )");
  }, version: 1);
  return db;
}

Future<File> _setImageDirectory(File? image) async {
  final appDir = await sys_paths.getApplicationDocumentsDirectory();
  final fileName = path.basename(image!.path);
  final copiedImage = await image.copy("${appDir.path}/$fileName");
  return copiedImage;
}

String _dbName = ConstantsUtil.dataBaseName;

class PlacesNotifier extends StateNotifier<List<Place>> {
  PlacesNotifier() : super([]);

  //
  void editPlacesList(Place place) async {
    final db = await _getDataBase();

    final copiedImage = await _setImageDirectory(place.image);
    final newPlace = Place(
      name: place.name,
      placeLocation: place.placeLocation,
      image: copiedImage,
    );

    final placesInList = state.contains(newPlace);
    if (placesInList) {
      state = state.where((m) => m.id != newPlace.id).toList();
    } else {
      db.insert(_dbName, {
        'id': newPlace.id,
        'name': newPlace.name,
        'imagepath': newPlace.image!.path,
        'lat': newPlace.placeLocation!.latitude,
        'lng': newPlace.placeLocation!.longitude,
        'address': newPlace.placeLocation!.address
      });
      state = [...state, newPlace];
    }
  }

  Future<void> loadPlaces() async {
    final db = await _getDataBase();
    final rawListData = await db.query(_dbName);
    final listItems = List.generate(rawListData.length, (index) {
      final item = rawListData[index];
      return Place(
          id: item['id'] as String,
          name: item['name'] as String,
          image: File(
            item['imagepath'] as String,
          ),
          placeLocation: PlaceLocation(
            address: item['address'] as String,
            latitude: item['lat'] as double,
            longitude: item['lng'] as double,
          ));
    });
    state = [...listItems];
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

  void returnStoredList() async {
    await serviceRef.read(placeProvider.notifier).loadPlaces();
  }
}
