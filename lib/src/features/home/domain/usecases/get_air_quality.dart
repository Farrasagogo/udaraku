import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';
import 'package:udaraku/src/features/home/domain/repositories/air_quality_repository.dart';

class GetAirQuality {
  final AirQualityRepository repository;

  GetAirQuality(this.repository);

  Stream<List<AirQuality>> call() {
    return repository.getAirQualityStream();
  }
}
