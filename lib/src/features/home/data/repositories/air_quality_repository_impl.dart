import 'package:firebase_database/firebase_database.dart';
import 'package:udaraku/src/features/home/data/models/air_quality_model.dart';
import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';
import 'package:udaraku/src/features/home/domain/repositories/air_quality_repository.dart';

class AirQualityRepositoryImpl implements AirQualityRepository {
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Stream<List<AirQuality>> getAirQualityStream() {
    return _database.child('air_quality').onValue.map((event) {
      final dynamic data = event.snapshot.value;
      if (data == null) {
        return [];
      } else if (data is Map<dynamic, dynamic>) {
        return data.entries.map((entry) {
          final value = entry.value as Map<dynamic, dynamic>;
          return AirQualityModel(
            location: entry.key,
            aqi: value['aqi'] as int,
            humidity: value['hum'] as int,
            temperature: value['temp'] as int,
          );
        }).toList();
      } else {
        return [];
      }
    });
  }
}
