import 'package:flutter/material.dart';
import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';
import 'package:udaraku/src/features/home/domain/usecases/get_air_quality.dart';
import 'package:udaraku/src/features/home/data/repositories/air_quality_repository_impl.dart';

class AirQualityViewModel extends ChangeNotifier {
  final GetAirQuality _getAirQuality;
  List<AirQuality>? airQualities;

  AirQualityViewModel() : _getAirQuality = GetAirQuality(AirQualityRepositoryImpl()) {
    _init();
  }

  void _init() {
    _getAirQuality().listen((data) {
      airQualities = data;
      notifyListeners();
    });
  }
}
