import 'package:flutter/material.dart';
import 'package:google_map_case/di/inject_providers.dart';
import 'package:google_map_case/view/map_screen_view.dart';

void main() {
  runApp(
    const AppProviders(
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Maps Case',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MapScreen(),
    );
  }
}
