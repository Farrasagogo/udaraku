import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';

abstract class AirQualityRepository {
  Stream<List<AirQuality>> getAirQualityStream();
}
