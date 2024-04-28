import 'package:flutter/material.dart';

class CustomMarker extends StatelessWidget {
  final String profilePictureUrl;
  final String distance;
  const CustomMarker({super.key, required this.distance, required this.profilePictureUrl});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 36,
              backgroundImage: NetworkImage(profilePictureUrl),
            ),
            SizedBox(
              height: 42,
              child: Text(
                "$distance km",
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
