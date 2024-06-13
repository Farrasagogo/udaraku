import 'package:flutter/material.dart';
import 'package:udaraku/src/features/geo/data/geo_repositories.dart';
import 'package:udaraku/src/utils/user_manager.dart';
import 'package:udaraku/src/features/geo/data/geocoding_service.dart';

<<<<<<< HEAD

=======
>>>>>>> 31e0db8a06dfb47ff3f0e55147a82cb8ae5664cf
class GeoViewModel extends ChangeNotifier {
  final UserManager _userManager;
  final AirQualityService _airQualityService;
  final GeocodingService _geocodingService;
<<<<<<< HEAD

=======
  
>>>>>>> 31e0db8a06dfb47ff3f0e55147a82cb8ae5664cf
  GeoViewModel(this._userManager, this._airQualityService, this._geocodingService);

  String? userName;
  double? latitude;
  double? longitude;
  String? locality;
  Map<String, dynamic>? airQualityData;
  String? errorMessage;
<<<<<<< HEAD
  bool isLoading = false;

  Future<void> fetchUserData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

=======

  Future<void> fetchUserData() async {
>>>>>>> 31e0db8a06dfb47ff3f0e55147a82cb8ae5664cf
    try {
      var userData = await _userManager.getUserLocation();
      if (userData != null) {
        userName = userData['name'];
        latitude = userData['latitude'];
        longitude = userData['longitude'];
        await fetchLocality();
      } else {
        errorMessage = 'Failed to retrieve user data';
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
    }
<<<<<<< HEAD

    isLoading = false;
=======
>>>>>>> 31e0db8a06dfb47ff3f0e55147a82cb8ae5664cf
    notifyListeners();
  }

  Future<void> fetchLocality() async {
    if (latitude != null && longitude != null) {
      locality = await _geocodingService.getLocality(latitude!, longitude!);
      if (locality == null || locality!.startsWith("Error")) {
<<<<<<< HEAD
        errorMessage = locality;
=======
        errorMessage = locality;  // Store the error message
>>>>>>> 31e0db8a06dfb47ff3f0e55147a82cb8ae5664cf
      } else {
        await fetchAirQualityData(locality!);
      }
    } else {
      errorMessage = 'Latitude or longitude is null';
    }
    notifyListeners();
  }

  Future<void> fetchAirQualityData(String location) async {
    try {
      airQualityData = await _airQualityService.getAirQualityData(location);
      if (airQualityData == null) {
        errorMessage = "Failed to fetch air quality data for $location";
      }
    } catch (e) {
      errorMessage = 'An error occurred: $e';
    }
    notifyListeners();
  }
}
