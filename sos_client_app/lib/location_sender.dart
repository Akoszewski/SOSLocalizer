import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class LocationSender {
  LocationSender() {
    Uri serverUri = Uri.parse("ws://3.68.186.250:7777");
    channel = WebSocketChannel.connect(serverUri);
  }

  late WebSocketChannel channel;

  // Future<bool> _checkLocationPermission() {}

  Future<bool> sendPosition() async {
    Position pos = await _determinePosition();
    await _sendData(pos.toString());
    print(pos);
    return true;
  }

  Future<bool> _sendData(String data) async {
    channel.sink.add(utf8.encode(data));
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
