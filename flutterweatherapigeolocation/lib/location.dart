import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  double? latitude;
  double? longitude;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled = false;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service are disabled");
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error("Location Permissions are denied");
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          "Location Permissions are permanently denied, we cannot request permissions.");
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      this.latitude = position.latitude;
      this.longitude = position.longitude;

      print("Latitude");
      print(this.latitude);
      print("Longitude");
      print(this.longitude);
    } catch (e) {
      return Future.error(e);
    }
  }
}
