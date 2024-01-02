import 'dart:io';

import 'package:favorite_places/data/models/place.dart';
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class PlaceRepository {
  PlaceRepository();

 List<Place> listPlaces = [];
 

  Future loadPlaces(Database? database) async {
    final db = database;

    final data = await db!.query('user_places');

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

   addPlace(String title, File image, PlaceLocation location, {required Database? database}) async {
    final appDir = await syspaths.getApplicationCacheDirectory();

    final fileName = path.basename(image.path);

    final copiedImage = await image.copy('${appDir.path}/$fileName');

    final newPlace = Place(
      image: copiedImage,
      location: location,
      title: title,
    );

    final db =  database;

    db!.insert(
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
