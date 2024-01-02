import 'dart:io';

import 'package:favorite_places/cubit_database/database_cubit.dart';
import 'package:favorite_places/data/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;

class PlaceRepository {
  PlaceRepository();

  List listPlaces = [];
 

  Future loadPlaces(DatabaseCubit database) async {
    final db = await database.getDatabase();

    final data = await db.query('user_places');

    final places = data
        .map(
          (row) => Place(
            title: row['title'] as String,
            image: File(row['image'] as String),
            location: PlaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();

    listPlaces = places;
  }

   addPlace(String title, File image, PlaceLocation location, {required DatabaseCubit database}) async {
    final appDir = await syspaths.getApplicationCacheDirectory();

    final fileName = path.basename(image.path);

    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Place(
      image: copiedImage,
      location: location,
      title: title,
    );

    final db = await database.getDatabase();

    db.insert(
      'user_places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': newPlace.image.path,
        'lat': newPlace.location.latitude,
        'lng': newPlace.location.longitude,
        'address': newPlace.location.address,
      },
    );
    listPlaces = [newPlace, ...listPlaces];
  }
}
