import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'sos_marker.dart';

class MainMap extends StatelessWidget {
  MainMap(String coordsStr, {Key? key}) : super(key: key) {
    coords = parseCoords(coordsStr);
  }
  late final List<double> coords;

  List<double> parseCoords(String coordsStr) {
    if (coordsStr.length > 0) {
      List<String> split = coordsStr.replaceAll(",", "").split(" ");
      print(split[0]);
      print(split[1]);
      return [double.parse(split[1]), double.parse(split[3])];
    } else {
      return [52.5, 21];
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth * 0.9,
      height: screenHeight * 0.7,
      margin: EdgeInsets.all(screenWidth * 0.1),
      child: FlutterMap(
        options: MapOptions(
          center: LatLng(coords[0], coords[1]),
          //center: null,
          zoom: 13.0,
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
                width: 10.0,
                height: 10.0,
                point: LatLng(coords[0], coords[1]),
                builder: (ctx) => const SosMarker(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
