import 'package:cloud_firestore/cloud_firestore.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  String? _userId;

  String? get userId => _userId;

  set userId(String? value) {
    _userId = value;
  }
Future<String?> getUserName() async {
    if (_userId == null) return null;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();

    if (userDoc.exists) {
      return userDoc['name'];
    } else {
      return null;
    }
  }
  Future<Map<String, dynamic>?> getUserLocation() async {
    if (_userId == null) return null;

    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(_userId).get();

    if (userDoc.exists) {
      return {
        'latitude': userDoc['latitude'],
        'longitude': userDoc['longitude'],
        'name': userDoc['name']
      };
    } else {
      return null;
    }
  }
}
