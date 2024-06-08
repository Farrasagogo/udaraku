import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';

class AirQualityModel extends AirQuality {
  final int humidity;
  final int temperature;

  AirQualityModel({
    required String location,
    required int aqi,
    required this.humidity,
    required this.temperature,
  }) : super(location: location, aqi: aqi);

  factory AirQualityModel.fromMap(Map<String, dynamic> data) {
    return AirQualityModel(
      location: data['location'] as String,
      aqi: data['aqi'] as int,
      humidity: data['humidity'] as int,
      temperature: data['temperature'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'aqi': aqi,
      'humidity': humidity,
      'temperature': temperature,
    };
  }
}
