import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'sos_marker.dart';

class MainMap extends StatelessWidget {
  MainMap({Key? key, required this.userCoords, this.sosCoords})
      : super(key: key);
  late final LatLng userCoords;
  late final LatLng? sosCoords;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: userCoords,
        //center: null,
        zoom: 8,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: (sosCoords != null) ? 10.0 : 0,
              height: (sosCoords != null) ? 10.0 : 0,
              point: sosCoords ?? LatLng(0, 0),
              builder: (ctx) => const SosMarker(),
            ),
          ],
        ),
      ],
    );
  }
}
