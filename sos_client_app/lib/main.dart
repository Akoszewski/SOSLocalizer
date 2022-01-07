import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sos_client_app/location_sender.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:latlong2/latlong.dart';
import 'location_data.dart';
import 'main_map.dart';
import "sos_button.dart";

void main() {
  setPathUrlStrategy(); // Usuwa # w adresie url strony
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final LocationSender locationSender;

  MyApp({Key? key}) : super(key: key) {
    locationSender = LocationSender();
  }

  void _onSOS() async {
    await locationSender.sendPosition();
  }

  LatLng parseServerResponse(String receivedStr) {
    print("Received: $receivedStr");
    Map<String, dynamic>? json = jsonDecode(receivedStr);
    LocationData data = LocationData.fromJson(json!);
    return LatLng(data.latitude, data.longitude);
  }

  List<LatLng> sosMarkerLocations = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOSLocalizer',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          body: Stack(alignment: Alignment.center, children: [
        StreamBuilder(
          stream: locationSender.channel.stream,
          builder: (context, snapshot) {
            print("Dziala ${snapshot.data.toString()}");
            if (snapshot.data != null) {
              print("Dziala2");
              LatLng location = parseServerResponse(snapshot.data.toString());
              sosMarkerLocations.add(location);
              print(
                  "SOS marker locations length: ${sosMarkerLocations.length}");
            }
            return MainMap(sosLocationList: sosMarkerLocations);
          },
        ),
        Positioned(
          bottom: 20,
          child: SosButton(text: "SOS", callback: _onSOS),
        )
      ])),
    );
  }
}
