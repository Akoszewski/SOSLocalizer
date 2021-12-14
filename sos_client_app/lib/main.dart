import 'package:flutter/material.dart';
import 'package:sos_client_app/location_sender.dart';
import 'main_map.dart';
import "sos_button.dart";

void main() => runApp(MyApp());

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
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              StreamBuilder(
                stream: locationSender.channel.stream,
                builder: (context, snapshot) {
                  return MainMap(snapshot.hasData ? '${snapshot.data}' : '');
                  // return Text(snapshot.hasData ? '${snapshot.data}' : '');
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
