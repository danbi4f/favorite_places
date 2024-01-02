import 'package:favorite_places/cubit_database/database_cubit.dart';
import 'package:favorite_places/cubit_place/place_cubit.dart';
import 'package:favorite_places/data/models/place.dart';
import 'package:favorite_places/pages/add_place_screen.dart';
import 'package:favorite_places/widgets/place_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesScreen extends StatefulWidget {
  const PlacesScreen({super.key});

  @override
  State<PlacesScreen> createState() => _PlacesScreenState();
}

class _PlacesScreenState extends State<PlacesScreen> {
   
  @override
  Widget build(BuildContext context) {
    PlaceCubit placeCubit = PlaceCubit(database: context.read<DatabaseCubit>().database);
    return BlocProvider(
      create: (context) => placeCubit..loadPlaces(),
      child: Scaffold(
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
        body: const PlacesList(),
      ),
    );
  }
}
//