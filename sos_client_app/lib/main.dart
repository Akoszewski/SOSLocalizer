import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sos_client_app/location_sender.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:latlong2/latlong.dart';
import 'server_message.dart';
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
            if (snapshot.data != null) {
              ServerMessage msg = ServerMessage.fromResponse(snapshot.data!);
              if (msg.command == "SOS") {
                sosMarkerLocations.add(LatLng(msg.latitude, msg.longitude));
              }
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
