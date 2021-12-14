import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

void main() => runApp(MyApp());

Future<bool> _getData() async {
  Socket socket = await Socket.connect("192.168.0.161", 4567);
  print("connected");
  socket.listen((List<int> event) {
    print(utf8.decode(event));
  });
  //socket.add(utf8.encode(data));
  await Future.delayed(Duration(seconds: 50));
  socket.close();
  return true;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _getData();
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Welcome to Flutter'),
        ),
        body: Center(
            child: FlutterMap(
          options: MapOptions(
            center: LatLng(52.5, 21),
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
                  width: 80.0,
                  height: 80.0,
                  point: LatLng(52.5, 21),
                  builder: (ctx) => Container(
                    child: FlutterLogo(),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
