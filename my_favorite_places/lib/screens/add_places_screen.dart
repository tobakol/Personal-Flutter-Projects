import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_favorite_places/viewutils/widgets_extensions.dart';

import '../models/place.dart';
import '../providers/places_provider.dart';
import '../viewutils/default_scaffold.dart';
import '../viewutils/inputs/image_input.dart';
import '../viewutils/inputs/location_input.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final placeNameController = TextEditingController();
  File pickedImage = File("");
  PlaceLocation? pickedLocationData;
  Place newPlace = Place();
  @override
  Widget build(BuildContext context) {
    final placeProviderService = PlacesProviderService(serviceRef: ref);
    return DefaultScaffold(
      title: "Add a place",
      body: Form(
          key: _formKey,
          child: Column(children: [
            TextFormField(
              style: const TextStyle(color: Colors.white),
              controller: placeNameController,
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().length <= 5 || value.trim().length > 50) {
                  return "Invalid name";
                }
                return null;
              },
              onSaved: (newValue) => newPlace = Place(
                name: newValue,
              ),
            ).spaceTo(bottom: 16),
            ImageInput(
              onChooseImage: (image) => pickedImage = image,
            ).spaceTo(bottom: 16),
            LocationInput(
              onChooseLocation: (placeLocation) => pickedLocationData = placeLocation,
            ),
            ElevatedButton(
                onPressed: () {
                  saveItem(ref, placeProviderService);
                },
                child: const Text("Add Place"))
          ])).paddingSymmetric(horizontal: 24, vertical: 16),
    );
  }

  void saveItem(WidgetRef serviceRef, PlacesProviderService placeProviderService) {
    _formKey.currentState!.save();
    newPlace = Place(name: placeNameController.text.trim(), image: pickedImage, placeLocation: pickedLocationData);
    placeProviderService.editPlaceList(newPlace);
    Navigator.pop(context);
  }
}
