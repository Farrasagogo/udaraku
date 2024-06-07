import 'package:flutter/material.dart';
import 'package:udaraku/src/features/auth/data/auth_repository.dart';

class LoginViewModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  GlobalKey<FormState> get formKey => _formKey;

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get password => _password;
  set password(String value) {
    _password = value;
  }

  Future<void> login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = await AuthRepository().login(email, password);
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login Failed')),
        );
      }
    }
  }
}
