// User Class for Data Management
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class User with ClusterItem {
  final int id;
  final String name;
  final double lat;
  final double long;
  final String image;

  User({
    required this.id,
    required this.name,
    required this.lat,
    required this.long,
    required this.image,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User &&
        other.id == id &&
        other.name == name &&
        other.lat == lat &&
        other.long == long &&
        other.image == image;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ lat.hashCode ^ long.hashCode ^ image.hashCode;
  }

  @override
  LatLng get location => LatLng(lat, long);
}
