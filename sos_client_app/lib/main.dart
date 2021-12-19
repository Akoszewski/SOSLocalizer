import 'package:flutter/material.dart';
import 'package:sos_client_app/location_sender.dart';
import 'package:url_strategy/url_strategy.dart';
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SOSLocalizer',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.yellow[100],
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          StreamBuilder(
            stream: locationSender.channel.stream,
            builder: (context, snapshot) {
              return MainMap(snapshot.hasData ? '${snapshot.data}' : '');
            },
          ),
          SosButton(callback: _onSOS),
        ])),
      ),
    );
  }

  // @override
  // void dispose() {
  //   locationSender.channel.sink.close();
  //   super.dispose();
  // }
}
