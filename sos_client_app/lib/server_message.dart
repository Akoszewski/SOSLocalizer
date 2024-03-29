import 'dart:convert';

class ServerMessage {
  String command;
  int? userId;
  double? latitude;
  double? longitude;

  ServerMessage(this.command, this.userId, this.latitude, this.longitude);
  ServerMessage.fromJson(Map<String, dynamic> json)
      : command = json['command'],
        userId = json['uid'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  factory ServerMessage.fromResponse(Object receivedData) {
    String receivedStr = receivedData.toString();
    print("Received: $receivedStr");
    Map<String, dynamic> json = jsonDecode(receivedStr);
    ServerMessage msg = ServerMessage.fromJson(json);
    return msg;
  }

  Map<String, dynamic> toJson() =>
      {'command': command, 'latitude': latitude, 'longitude': longitude};
}
