import 'package:latlong2/latlong.dart';

class LocationData {
  String command;
  double latitude;
  double longitude;

  LocationData(this.command, this.latitude, this.longitude);
  LocationData.fromJson(Map<String, dynamic> json)
      : command = json['command'],
        latitude = json['latitude'],
        longitude = json['longitude'];

  Map<String, dynamic> toJson() =>
      {'command': command, 'latitude': latitude, 'longitude': longitude};
}
