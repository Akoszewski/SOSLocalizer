import 'package:flutter/material.dart';
import 'package:sos_client_app/location_sender.dart';
import "sos_button.dart";

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  final LocationSender locationSender;

  const MyApp({Key? key})
      : locationSender = const LocationSender(),
        super(key: key);

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
        body: Center(child: SosButton(callback: _onSOS)),
      ),
    );
  }
}
