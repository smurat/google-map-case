import 'package:flutter/material.dart';
import 'package:google_map_case/model/user_model.dart';

// Carousel Service (Single Responsibility)
class CarouselService extends ChangeNotifier {
  List<User> users;

  CarouselService(this.users);

  List<Widget> buildCarousel(Function(int) onPageChanged) {
    return users.map((user) {
      return Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(user.image),
          ),
          title: Text(user.name),
          subtitle: Text('LatLng: ${user.lat}, Long: ${user.long}'),
        ),
      );
    }).toList();
  }
}
