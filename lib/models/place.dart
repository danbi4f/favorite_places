import 'dart:io';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;
}

class Place {
  Place({
    required this.image,
    required this.location,
    required this.title,
    String? id,
  }) : id = id ?? uuid.v4();

  String id;
  final String title;
  final File image;
  final PlaceLocation location;
}
