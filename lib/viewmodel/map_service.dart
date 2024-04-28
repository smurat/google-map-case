// Map Service (Single Responsibility)
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapService extends ChangeNotifier {
  GoogleMapController? controller;

  void setController(GoogleMapController mapController) {
    controller = mapController;
  }

  void animateToLocation(LatLng location) {
    controller?.animateCamera(
      CameraUpdate.newLatLng(location),
    );
  }
}
