import 'package:geocoding/geocoding.dart';

class GeocodingService {
  Future<String?> getLocality(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        return placemarks.first.locality;
      }
      return "No results found for Lat: $latitude, Long: $longitude";
    } catch (e) {
      if (e.toString().contains("quota")) {
        return "Rate limit has been reached for Lat: $latitude, Long: $longitude";
      }
      return "Error in geocoding: QUOTA RATE LIMIT HAS BEEN REACHED $e";
    }
  }
}
