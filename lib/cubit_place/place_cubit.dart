import 'dart:io';

import 'package:favorite_places/cubit_database/database_cubit.dart';
import 'package:favorite_places/data/models/place.dart';
import 'package:favorite_places/data/repositories/place_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'place_state.dart';

class PlaceCubit extends Cubit<PlaceState> {
  PlaceCubit({required this.database}) : super(PlaceInitial());

  final DatabaseCubit database;
  final _placeRepo = PlaceRepository();

  List _places = [];
  get pleces => _places;

  Future<void> loadPlaces() async {
    _places = await _placeRepo.loadPlaces(database);
    emit(PlaceInitial());
  }

  Future addPlace(String title, File image, PlaceLocation location,
      {required DatabaseCubit database}) async {
    _places =
        await _placeRepo.addPlace(title, image, location, database: database);
    emit(PlaceInitial());
    loadPlaces();
  }
}
