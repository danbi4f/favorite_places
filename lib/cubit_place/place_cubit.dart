import 'dart:io';

import 'package:favorite_places/data/models/place.dart';
import 'package:favorite_places/data/repositories/place_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit({required this.database}) : super(PlaceInitial());

  final Database? database;
  final placeRepo = PlaceRepository();

  final List<Place> places = PlaceRepository().listPlaces;

  Future<void> loadPlaces() async {
    await placeRepo.loadPlaces(database);
    emit(PlaceInitial());
  }

  Future addPlace(String title, File image, PlaceLocation location) async {
    await placeRepo.addPlace(title, image, location, database: database);
    emit(PlaceInitial());
    loadPlaces();
  }
}
