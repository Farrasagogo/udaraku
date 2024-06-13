import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:udaraku/src/utils/user_manager.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> login(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      UserManager().userId = userCredential.user?.uid; // Set the global user ID
      await _saveUserLocation();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      UserManager().userId = userCredential.user?.uid; // Set the global user ID
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

  Future<Map<String, dynamic>> getUserProfile() async {
    String? userId = UserManager().userId;
    if (userId != null) {
      DocumentSnapshot doc = await _firestore.collection('users').doc(userId).get();
      return doc.data() as Map<String, dynamic>;
    }
    return {};
  }

  Future<void> updateUserProfile(String name) async {
    String? userId = UserManager().userId;
    if (userId != null) {
      await _firestore.collection('users').doc(userId).update({
        'name': name,
      });
    }
  }

  Future<void> updateUserPassword(String newPassword) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.updatePassword(newPassword);
    }
  }

  Future<bool> reauthenticateUser(String oldPassword) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && user.email != null) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user.email!,
          password: oldPassword,
        );
        await user.reauthenticateWithCredential(credential);
        return true;
      } catch (e) {
        // Handle reauthentication failure
        return false;
      }
    }
    return false;
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

    String? userId = UserManager().userId;
    if (userId != null) {
      await _firestore.collection('users').doc(userId).update({
        'latitude': position.latitude,
        'longitude': position.longitude,
      });
    }
  }
}
