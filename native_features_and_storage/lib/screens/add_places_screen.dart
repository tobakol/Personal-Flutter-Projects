import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:native_features_and_storage/viewutils/widgets_extensions.dart';

import '../models/place.dart';
import '../providers/places_provider.dart';
import '../viewutils/default_scaffold.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _formKey = GlobalKey<FormState>();
  final placeNameController = TextEditingController();
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
              controller: placeNameController,
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().length <= 5 || value.trim().length > 50) {
                  return "Invalid name";
                }
                return null;
              },
              onSaved: (newValue) => newPlace = Place(name: newValue,),
            ).padding(bottom: 16),
            ElevatedButton(
                onPressed: () {
                  saveItem(ref, placeProviderService);
                },
                child: const Text("Add Place"))
          ])),
    );
  }

  void saveItem(WidgetRef serviceRef, PlacesProviderService placeProviderService) {
    _formKey.currentState!.save();
    placeProviderService.editPlaceList(newPlace);
    Navigator.pop(context);
  }
}