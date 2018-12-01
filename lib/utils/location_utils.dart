import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationUtils {
  Future<GeolocationStatus> checkPermission() async {
    GeolocationStatus permission =
        await Geolocator().checkGeolocationPermissionStatus();
    return permission;
  }

  Future<Position> getLocation() async {
    Position location;
    location = await Geolocator().getCurrentPosition();
    return location;
  }
}
