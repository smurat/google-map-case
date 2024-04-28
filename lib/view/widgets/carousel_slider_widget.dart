import 'package:flutter/material.dart';
import 'package:flutter_carousel_slider/carousel_slider.dart';
import 'package:google_map_case/viewmodel/carousel_service.dart';
import 'package:google_map_case/viewmodel/location_service.dart';
import 'package:google_map_case/viewmodel/map_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CarouselSliderWidget extends StatelessWidget {
  const CarouselSliderWidget({
    super.key,
    required this.carouselService,
    required this.mapService,
    required this.locationService,
  });

  final CarouselService carouselService;
  final MapService mapService;
  final LocationService locationService;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
        itemCount: carouselService.users.length,
        onSlideChanged: (index) {
          mapService.animateToLocation(
            LatLng(
              carouselService.users[index].lat,
              carouselService.users[index].long,
            ),
          );
        },
        slideBuilder: (index) {
          final user = carouselService.users[index];
          return Card(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(user.image),
                        ),
                        const SizedBox(width: 8),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(carouselService.users[index].name),
                            Text(
                              'Uzaklık: ${locationService.calculateDistance(LatLng(user.lat, user.long))} km',
                            ),
                          ],
                        ),
                      ],
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chevron_right),
                    ),
                  ],
                ),
              ],
            ),
          ));
        });
  }
}
