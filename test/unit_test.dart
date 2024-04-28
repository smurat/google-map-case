import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_case/constants/dummy_user_data.dart';
import 'package:google_map_case/viewmodel/cluster_manager_service.dart';
import 'package:google_map_case/viewmodel/location_service.dart';
import 'package:google_map_case/viewmodel/map_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([GoogleMapController]) // Mock sınıfını oluşturur
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MapService', () {
    test('setController sets the GoogleMapController correctly', () {
      final mapService = MapService();
      final mockController = MockGoogleMapController();
      mapService.setController(mockController);
      expect(mapService.controller, equals(mockController));
    });

    test('animateToLocation moves the camera to the specified location', () {
      final mapService = MapService();
      final mockController = MockGoogleMapController();
      mapService.setController(mockController);

      const location = LatLng(39.9334, 32.8597);
      mapService.animateToLocation(location);

      verify(mockController.animateCamera(
        CameraUpdate.newLatLng(location),
      )).called(1);
    });
  });

  group('LocationService', () {
    test('initLocationService sets the user position', () async {
      final locationService = LocationService();
      await locationService.initLocationService();
      expect(locationService.userPosition, isNotNull);
    });

    test('calculateDistance returns the correct distance', () {
      final locationService = LocationService();
      locationService.userPosition = Position(
        latitude: 39.9334,
        longitude: 32.8597,
        altitudeAccuracy: 0,
        headingAccuracy: 0,
        isMocked: true,
        timestamp: DateTime.now(),
        accuracy: 1.0,
        altitude: 1.0,
        heading: 1.0,
        speed: 1.0,
        speedAccuracy: 1.0,
      );

      const markerPosition = LatLng(39.5965, 32.4549);
      final distance = locationService.calculateDistance(markerPosition);
      expect(distance, isPositive);
    });
  });

  group('ClusterManagerService', () {
    test('_initClusterManager sets up the cluster manager correctly', () {
      final users = getDummyUsers();
      final clusterService = ClusterManagerService(users);
      expect(clusterService.clusterManager, isNotNull);
    });

    test('_updateMarkers updates the markers correctly', () {
      final users = getDummyUsers();
      final clusterService = ClusterManagerService(users);
      final markers = <Marker>{};
      clusterService.updateMarkers(markers);
      expect(clusterService.markers, equals(markers));
    });
  });
}
