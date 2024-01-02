import 'package:favorite_places/cubit_database/database_cubit.dart';
import 'package:favorite_places/cubit_place/place_cubit.dart';
import 'package:favorite_places/data/models/place.dart';
import 'package:favorite_places/pages/place_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    PlaceCubit placeCubit =
        PlaceCubit(database: context.read<DatabaseCubit>().database);
    List<Place> userPlaces = placeCubit.placeRepo.listPlaces;
    if (userPlaces.isEmpty) {
      return const Center(
        child: Text('No places added yet'),
      );
    }

    return ListView.builder(
      itemCount: userPlaces.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(userPlaces[index].title),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlaceDetailScreen(
                place: userPlaces[index],
              ),
            ),
          );
        },
      ),
    );
  }
}
