import 'dart:js';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:latlong2/latlong.dart';

import 'package:geolocator/geolocator.dart';
import 'geolocation_web.dart';
import 'package:latlong2/latlong.dart';

success(pos) {
  try {
    print(pos.coords.latitude);
    print(pos.coords.longitude);
  } catch (ex) {
    print("Exception thrown : " + ex.toString());
  }
}

class Location {
  late LatLng coords;
  Future<LatLng> determineLocation() async {
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
    // Position position = Position(
    //   latitude: 0,
    //   longitude: 0,
    //   timestamp: DateTime(2021),
    //   accuracy: 0,
    //   altitude: 0,
    //   heading: 0,
    //   speed: 0,
    //   speedAccuracy: 0,
    // );

    LatLng coords = LatLng(0, 0);

    success(pos) {
      coords = LatLng(pos.coords.latitude, pos.coords.longitude);
    }

    if (kIsWeb) {
      getCurrentPosition(allowInterop((pos) {
        Function s = (pos) => success(pos);
        return s;
      }));
      return coords;
    } else {
      Position pos = await Geolocator.getCurrentPosition();
      return LatLng(pos.latitude, pos.longitude);
    }
  }
}
