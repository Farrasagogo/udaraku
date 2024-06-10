import 'package:cloud_firestore/cloud_firestore.dart';

class LocationService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> getLocalityFromFirestore(String userId) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      if (doc.exists) {
        return doc['locality'] as String?;
      }
    } catch (e) {
      print('Error fetching locality: $e');
    }
    return null;
  }
}
