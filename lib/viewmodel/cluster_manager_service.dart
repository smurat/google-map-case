import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_map_case/helper/widget_to_marker.dart';
import 'package:google_map_case/model/user_model.dart';
import 'package:google_map_case/widgets/custom_marker.dart';
import 'package:google_maps_cluster_manager/google_maps_cluster_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClusterManagerService extends ChangeNotifier {
  late ClusterManager<User> clusterManager;
  Set<Marker> markers = {};

  ClusterManagerService(List<User> users) {
    clusterManager = _initClusterManager(users);
  }

  ClusterManager<User> _initClusterManager(List<User> users) {
    return ClusterManager<User>(users, updateMarkers, markerBuilder: markerBuilder);
  }

  void updateMarkers(Set<Marker> markers) {
    debugPrint('Updated ${markers.length} markers');
    this.markers = markers;
    notifyListeners();
  }

  Future<Marker> Function(Cluster<User>) get markerBuilder {
    return (cluster) async {
      return Marker(
        markerId: MarkerId(cluster.getId()),
        position: cluster.location,
        icon: cluster.isMultiple
            ? await getMarkerBitmap(
                75,
                text: cluster.count.toString(),
              )
            : await const CustomMarker(
                    distance: "10", profilePictureUrl: 'https://randomuser.me/api/portraits/men/7.jpg')
                .toBitmapDescriptor(logicalSize: const Size(150, 150), imageSize: const Size(150, 150)),
        onTap: () {
          debugPrint("Cluster Tapped: $cluster");
          for (var p in cluster.items) {
            debugPrint("Item: ${p.name}");
          }
        },
      );
    };
  }

  Future<BitmapDescriptor> getMarkerBitmap(int size, {String? text}) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint1 = Paint()..color = Colors.orange;
    final Paint paint2 = Paint()..color = Colors.white;

    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.0, paint1);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.2, paint2);
    canvas.drawCircle(Offset(size / 2, size / 2), size / 2.8, paint1);

    if (text != null) {
      TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
      painter.text = TextSpan(
        text: text,
        style: TextStyle(fontSize: size / 3, color: Colors.white, fontWeight: FontWeight.normal),
      );
      painter.layout();
      painter.paint(
        canvas,
        Offset(size / 2 - painter.width / 2, size / 2 - painter.height / 2),
      );
    }

    final img = await pictureRecorder.endRecording().toImage(size, size);
    final data = await img.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}