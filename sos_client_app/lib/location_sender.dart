import 'dart:convert';
import 'package:sos_client_app/server_message.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
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
      ServerMessage data =
          ServerMessage("SOS", coords.latitude, coords.longitude);
      String encodedData = jsonEncode(data);
      await _sendData(encodedData);
    }
    return true;
  }

  Future<bool> _sendData(String data) async {
    channel.sink.add(utf8.encode(data));
    return true;
  }
}
