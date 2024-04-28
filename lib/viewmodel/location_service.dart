// LocationService (Separate Responsibility)
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationService extends ChangeNotifier {
  Position? userPosition;

  LocationService() {
    initLocationService();
  }

  Future<void> initLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      debugPrint("Location services are disabled.");
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        debugPrint("Location permissions are denied.");
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      debugPrint("Location permissions are permanently denied.");
      return;
    }

    // Retrieve the user's current location
    userPosition = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    notifyListeners();
  }

  int calculateDistance(LatLng markerPosition) {
    if (userPosition == null) {
      return -1; // If user position is not available
    }

    // Calculate distance in km
    return (Geolocator.distanceBetween(
              userPosition!.latitude,
              userPosition!.longitude,
              markerPosition.latitude,
              markerPosition.longitude,
            ) /
            1000)
        .roundToDouble()
        .toInt();
  }
}
