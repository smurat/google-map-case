// Map Screen with Carousel Integration
import 'package:flutter/material.dart';
import 'package:google_map_case/view/widgets/carousel_slider_widget.dart';
import 'package:google_map_case/viewmodel/carousel_service.dart';
import 'package:google_map_case/viewmodel/cluster_manager_service.dart';
import 'package:google_map_case/viewmodel/location_service.dart';
import 'package:google_map_case/viewmodel/map_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapScreen extends StatelessWidget {
  // Türkiye location
  final LatLng initialLocation = const LatLng(39.9334, 32.8597);

  const MapScreen({super.key}); // Örnek konum

  @override
  Widget build(BuildContext context) {
    final mapService = Provider.of<MapService>(context);
    final locationService = Provider.of<LocationService>(context);
    final clusterService = Provider.of<ClusterManagerService>(context);
    final carouselService = Provider.of<CarouselService>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Maps Case'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          mapService.animateToLocation(
              LatLng(locationService.userPosition!.latitude, locationService.userPosition!.longitude));
        },
        child: const Icon(Icons.my_location),
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (controller) {
              mapService.setController(controller);
              clusterService.clusterManager.setMapId(controller.mapId);
            },
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            initialCameraPosition: CameraPosition(
              target: initialLocation,
              zoom: 7,
            ),
            onCameraMove: (position) {
              clusterService.clusterManager.onCameraMove(position);
            },
            onCameraIdle: () {
              clusterService.clusterManager.updateMap();
            },
            markers: clusterService.markers,
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: 100,
              child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSliderWidget(
                      carouselService: carouselService,
                      mapService: mapService,
                      locationService: locationService)),
            ),
          ),
        ],
      ),
    );
  }
}
