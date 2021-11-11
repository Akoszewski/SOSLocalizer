import 'dart:convert';
import 'dart:io';

import 'package:geolocator/geolocator.dart';

class LocationSender {
  const LocationSender();

  // Future<bool> _checkLocationPermission() {}

  Future<bool> sendPosition() async {
    Position pos = await _determinePosition();
    await _sendData(pos.toString());
    print(pos);
    return true;
  }

  Future<bool> _sendData(String data) async {
    Socket socket = await Socket.connect("192.168.0.161", 4567);
    print("connected");
    socket.listen((List<int> event) {
      print(utf8.decode(event));
    });
    socket.add(utf8.encode(data));
    //await Future.delayed(Duration(seconds: 5));
    socket.close();
    return true;
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
