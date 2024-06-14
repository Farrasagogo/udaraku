import 'package:flutter/material.dart';
import 'package:udaraku/src/features/geo/data/geo_repositories.dart';
import 'package:udaraku/src/utils/user_manager.dart';
import 'package:udaraku/src/features/geo/data/geocoding_service.dart';


class GeoViewModel extends ChangeNotifier {
  final UserManager _userManager;
  final AirQualityService _airQualityService;
  final GeocodingService _geocodingService;

  GeoViewModel(this._userManager, this._airQualityService, this._geocodingService);

  String? userName;
  double? latitude;
  double? longitude;
  String? locality;
  Map<String, dynamic>? airQualityData;
  String? errorMessage;
  bool isLoading = false;

  Future<void> fetchUserData() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

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

    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchLocality() async {
    if (latitude != null && longitude != null) {
      locality = await _geocodingService.getLocality(latitude!, longitude!);
      if (locality == null || locality!.startsWith("Error")) {
        errorMessage = locality;
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
