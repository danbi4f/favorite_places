import 'dart:io';

import 'package:favorite_places/cubit_database/database_cubit.dart';
import 'package:favorite_places/cubit_place/place_cubit.dart';
import 'package:favorite_places/data/models/place.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:favorite_places/widgets/location_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  File? _selectedImage;
  PlaceLocation? _selectedLocation;
  PlaceCubit? placeCubit;

  savePlace() {
    final String enteredTitle = _titleController.text;

    if (enteredTitle.isEmpty) {
      return;
    }
    
      placeCubit!.addPlace(enteredTitle, _selectedImage!, _selectedLocation!);
    
    print(placeCubit!.placeRepo.listPlaces);

    

    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
     placeCubit = PlaceCubit(database: context.read<DatabaseCubit>().database);
    return Scaffold(
      appBar: AppBar(
        title: const Text("add new place"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          ImageInput(
            onPickedImage: (image) {
              _selectedImage = image;
            },
          ),
          const SizedBox(height: 10),
          LocationInput(
            onSelectLocation: (location) {
              _selectedLocation = location;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: savePlace,
            icon: const Icon(Icons.add),
            label: const Text('Add place'),
          ),
        ],
      )),
    );
  }
}
