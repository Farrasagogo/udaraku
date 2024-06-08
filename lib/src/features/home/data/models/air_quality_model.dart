import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';

class AirQualityModel extends AirQuality {
  AirQualityModel({required String location, required int aqi})
      : super(location: location, aqi: aqi);

  factory AirQualityModel.fromMap(Map<String, dynamic> data) {
    return AirQualityModel(
      location: data['location'] as String,
      aqi: data['aqi'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'aqi': aqi,
    };
  }
}
