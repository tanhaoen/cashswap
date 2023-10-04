import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<LatLng?> _getCurrentLocation() async {
  try {
    // Request permission to access location
    LocationPermission permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      // Handle denied permission
      throw ('Permission denied');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    // Use the position object to access latitude and longitude
    double latitude = position.latitude;
    double longitude = position.longitude;

    return LatLng(latitude, longitude);
  } catch (e) {
    throw e;
  }
}
