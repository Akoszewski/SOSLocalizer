import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sos_client_app/location_sender.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:latlong2/latlong.dart';
import 'main_map.dart';
import "sos_button.dart";

void main() {
  setPathUrlStrategy(); // Usuwa # w adresie url strony
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late final LocationSender locationSender;

  bool isSosSignal = false;
  Timer? timer;

  int locationSendingPeriod = 10;

  MyApp({Key? key}) : super(key: key) {
    locationSender = LocationSender();
  }

  void _onSOS() {
    isSosSignal = isSosSignal ? false : true;
    if (isSosSignal) {
      locationSender.sendPosition();
    } else {
      locationSender.stopSOS();
    }
  }

  LatLng? parseCoords(String coordsStr) {
    if (coordsStr.isNotEmpty && coordsStr != "null") {
      List<String> split = coordsStr.split(" ");
      print("Coord str: " + coordsStr);
      return LatLng(double.parse(split[0]), double.parse(split[1]));
    } else {
      return null;
    }
  }

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
            // parseServerResponse(snapshot.data.toString()));
            String serverResponse = snapshot.data.toString();
            if (serverResponse == "STOP") {
            } else {
              return MainMap(sosCoords: parseCoords(serverResponse));
            }
          },
        ),
        Positioned(
          bottom: 20,
          child:
              SosButton(text: isSosSignal ? "STOP" : "SOS", callback: _onSOS),
        )
      ])),
    );
  }
}
