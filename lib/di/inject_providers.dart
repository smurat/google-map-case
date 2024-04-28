// Dependency Injection with Provider
import 'package:flutter/material.dart';
import 'package:google_map_case/constants/dummy_user_data.dart';
import 'package:google_map_case/viewmodel/carousel_service.dart';
import 'package:google_map_case/viewmodel/cluster_manager_service.dart';
import 'package:google_map_case/viewmodel/location_service.dart';
import 'package:google_map_case/viewmodel/map_service.dart';
import 'package:provider/provider.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders(this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MapService()),
        ChangeNotifierProvider(create: (_) => LocationService()),
        ChangeNotifierProvider(create: (_) => ClusterManagerService(getDummyUsers())),
        ChangeNotifierProvider(create: (_) => CarouselService(getDummyUsers())),
      ],
      child: child,
    );
  }
}
