import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      await _saveUserLocation();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'name': name,
        'email': email,
      });
      await _saveUserLocation();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _saveUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    } 

    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'location': {
          'latitude': position.latitude,
          'longitude': position.longitude,
        },
      });
    }
  }
}
