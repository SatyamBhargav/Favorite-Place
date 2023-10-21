import 'dart:io';

import 'package:favorite_place/model/place.dart';
import 'package:favorite_place/provider/user_place.dart';
import 'package:favorite_place/widget/image_input.dart';
import 'package:favorite_place/widget/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlace extends ConsumerStatefulWidget {
  const AddPlace({super.key});

  @override
  ConsumerState<AddPlace> createState() => _AddPlaceState();
}

class _AddPlaceState extends ConsumerState<AddPlace> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;

  void _savePlace() {
    final enteredTitel = _titleController.text;
    if (enteredTitel.isEmpty || _selectedImage == null || _selectedLocation == null) {
      return;
    }
    ref
        .read(UserPlacesProvider.notifier)
        .addPlace(enteredTitel, _selectedImage!,_selectedLocation!);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add new Place')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          TextField(
            decoration: const InputDecoration(label: Text('Title')),
            controller: _titleController,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(height: 20),
          ImageInput(
            onPickImage: (image) {
              _selectedImage = image;
            },
          ),
          const SizedBox(height: 20),
          LocationInput(
            onSelectLocation: (location) {
              _selectedLocation = location;
            },
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
              onPressed: _savePlace,
              icon: const Icon(Icons.add),
              label: const Text('Add Place'))
        ]),
      ),
    );
  }
}
