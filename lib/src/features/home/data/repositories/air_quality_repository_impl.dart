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
          final int aqi = entry.value is int ? entry.value : int.parse(entry.value.toString());
          return AirQualityModel(location: entry.key, aqi: aqi);
        }).toList();
      } else {
        return [];
      }
    });
  }
}
