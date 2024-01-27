import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class HomeServices {
  static Future<({Placemark? success, String? error})> getCurrentLocation(
      {Position? success, String? error}) async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      final places =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (places.isEmpty) {
        return (success: null, error: "No address found");
      }
      return (success: places[0], error: null);
    } catch (e) {
      return (success: null, error: "An error occurred");
    }
  }
}
