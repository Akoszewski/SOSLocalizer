import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sos_client_app/location.dart';

import 'sos_marker.dart';

class MainMap extends StatefulWidget {
  MainMap({Key? key, this.sosCoords}) : super(key: key) {}
  MapController mapController = MapController();

  late final LatLng? sosCoords;

  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  LatLng centerCoords = LatLng(52.2, 21);
  LatLng? parseCoords(String coordsStr) {
    if (coordsStr.isNotEmpty && coordsStr != "null") {
      List<String> split = coordsStr.replaceAll(",", "").split(" ");
      return LatLng(double.parse(split[1]), double.parse(split[3]));
    } else {
      return null;
    }
  }

  Future<LatLng?> getUserCoords() async {
    Location location = Location();
    return await location.determineLocation();
  }

  Future<void> setMapCenter() async {
    LatLng? newCoords = await getUserCoords();
    if (newCoords != null) {
      setState(() {
        widget.mapController.move(newCoords, 9);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setMapCenter();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: widget.mapController,
      options: MapOptions(
        center: centerCoords,
        zoom: 8,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return const Text("© OpenStreetMap contributors");
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: (widget.sosCoords != null) ? 100.0 : 0,
              height: (widget.sosCoords != null) ? 100.0 : 0,
              point: widget.sosCoords ?? LatLng(0, 0),
              builder: (ctx) => const SosMarker(),
            ),
          ],
        ),
      ],
    );
  }
}
