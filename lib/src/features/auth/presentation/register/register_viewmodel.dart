// udaraku/lib/src/features/auth/presentation/register/register_viewmodel.dart

import 'package:flutter/material.dart';
import 'package:udaraku/src/features/auth/data/auth_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  GlobalKey<FormState> get formKey => _formKey;

  String get name => _name;
  set name(String value) {
    _name = value;
  }

  String get email => _email;
  set email(String value) {
    _email = value;
  }

  String get password => _password;
  set password(String value) {
    _password = value;
  }

  Future<void> register(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      bool success = await AuthRepository().register(_name, _email, _password);
      if (success) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Failed')),
        );
      }
    }
  }
}
