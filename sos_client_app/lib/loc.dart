@JS('navigator.geolocation')
library jslocation;

import 'package:js/js.dart';
import 'dart:html';

@JS('getCurrentPosition')
external void getCurrentPosition(Function? success(Geoposition pos));

@JS()
@anonymous
class GeolocationCoordinates {
  external factory GeolocationCoordinates({
    double latitude,
    double longitude,
  });

  external double get latitude;
  external double get longitude;
}

@JS()
@anonymous
class GeolocationPosition {
  external factory GeolocationPosition({GeolocationCoordinates coords});

  external GeolocationCoordinates get coords;
}
