import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';

class AirQualityModel extends AirQuality {
  AirQualityModel({
    required String location,
    required int aqi,
    required String date,
    required int humidity,
    required int temperature,
  }) : super(
          location: location,
          aqi: aqi,
          date: date,
          humidity: humidity,
          temperature: temperature,
        );

  factory AirQualityModel.fromMap(Map<dynamic, dynamic> data, String location) {
    return AirQualityModel(
      location: location,
      aqi: data['aqi'] as int,
      date: data['date'] as String,
      humidity: data['hum'] as int,
      temperature: data['temp'] as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'aqi': aqi,
      'date': date,
      'humidity': humidity,
      'temperature': temperature,
    };
  }
}
