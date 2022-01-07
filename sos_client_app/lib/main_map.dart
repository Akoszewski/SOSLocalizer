import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:sos_client_app/location.dart';

import 'sos_marker.dart';

class MainMap extends StatefulWidget {
  final MapController mapController = MapController();
  final List<LatLng> sosLocationList;

  MainMap({Key? key, this.sosLocationList = const []}) : super(key: key);

  @override
  _MainMapState createState() => _MainMapState();
}

class _MainMapState extends State<MainMap> {
  LatLng centerCoords = LatLng(52.2, 21); // Domyslne poczatkowe ustawiene mapy

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

  List<Marker> generateMarkers() {
    List<Marker> markers = [];
    for (LatLng coords in widget.sosLocationList) {
      markers.add(Marker(
        width: 10,
        height: 10,
        point: coords,
        builder: (ctx) => const SosMarker(),
      ));
    }
    return markers;
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
          markers: generateMarkers(),
        ),
      ],
    );
  }
}
