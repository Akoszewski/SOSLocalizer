import 'dart:async';
import 'dart:html';
import 'dart:js';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:latlong2/latlong.dart';

import 'package:geolocator/geolocator.dart';
import 'loc.dart';
import 'package:latlong2/latlong.dart';

class Location {
  Future<LatLng?> determineLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    LatLng? coords;

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

    if (kIsWeb) {
      Completer completer = Completer();
      getCurrentPosition(allowInterop((pos) {
        completer.complete(pos);
      }));
      Geoposition pos = await completer.future;
      if (pos.coords != null) {
        if (pos.coords!.latitude != null && pos.coords!.longitude != null) {
          num lat = pos.coords!.latitude!;
          num long = pos.coords!.longitude!;
          coords = LatLng(lat.toDouble(), long.toDouble());
        } else {
          coords = null; // Moze zwrocic future error
        }
      } else {
        coords = null;
      }
      return coords;
    } else {
      Position pos = await Geolocator.getCurrentPosition();
      return LatLng(pos.latitude, pos.longitude);
    }
  }
}
