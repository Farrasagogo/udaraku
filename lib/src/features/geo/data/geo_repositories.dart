import 'package:firebase_database/firebase_database.dart';

class AirQualityService {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();

  Future<Map<String, dynamic>?> getAirQualityData(String location) async {
    DatabaseReference locationRef = _databaseReference.child('air_quality/$location');
    DataSnapshot snapshot = await locationRef.get();

    if (snapshot.exists) {
      return Map<String, dynamic>.from(snapshot.value as Map);
    } else {
      return null;
    }
  }
}
