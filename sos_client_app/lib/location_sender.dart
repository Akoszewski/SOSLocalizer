import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'location.dart';

class LocationSender {
  LocationSender() {
    print("Connecting to backend...");
    Uri serverUri = Uri.parse("wss://backend.sos-app.tk");
    channel = WebSocketChannel.connect(serverUri);
  }
  late WebSocketChannel channel;

  Future<bool> sendPosition() async {
    Location location = Location();
    LatLng? coords = await location.determineLocation();
    if (coords != null) {
      await _sendData(
          coords.latitude.toString() + " " + coords.longitude.toString());
    }
    return true;
  }

  Future<bool> stopSOS() async {
    await _sendData("STOP");
    return true;
  }

  Future<bool> _sendData(String data) async {
    channel.sink.add(utf8.encode(data));
    return true;
  }
}
