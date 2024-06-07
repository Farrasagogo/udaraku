import 'firebase_auth_service.dart';

class AuthRepository {
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<bool> login(String email, String password) async {
    try {
      await _authService.signInWithEmailAndPassword(email, password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(String email, String password) async {
    try {
      await _authService.createUserWithEmailAndPassword(email, password);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
