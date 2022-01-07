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

  Future<void> sendSOS() async {
    Location location = Location();
    LatLng? coords = await location.determineLocation();
    if (coords != null) {
      // UserId jest tutaj null bo dopiero serwer je przydzieli i odesle klientom
      ServerMessage data =
          ServerMessage("SOS", null, coords.latitude, coords.longitude);
      String encodedData = jsonEncode(data);
      await _sendData(encodedData);
    }
  }

  Future<void> stopSOS() async {
    String encodedData = jsonEncode({"command": "STOP"});
    await _sendData(encodedData);
  }

  Future<void> _sendData(String data) async {
    channel.sink.add(utf8.encode(data));
  }
}
