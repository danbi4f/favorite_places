import 'package:favorite_places/models/place.dart';
import 'package:favorite_places/pages/add_place_screen.dart';
import 'package:favorite_places/widgets/place_list.dart';
import 'package:flutter/material.dart';

class PlacesScreen extends StatelessWidget {
  const PlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Place> userPlaces = [];   // final userPlaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddPlaceScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
        title: const Text('Your Places'),
      ),
      body: PlacesList(places: userPlaces),
    );
  }
}
