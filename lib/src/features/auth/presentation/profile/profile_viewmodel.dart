import 'package:flutter/material.dart';
import 'package:udaraku/src/features/auth/data/auth_repository.dart';

class ProfileViewModel extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _oldPassword = '';
  String _newPassword = '';
  bool _isLoading = false;

  GlobalKey<FormState> get formKey => _formKey;

  String get name => _name;
  set name(String value) {
    _name = value;
    notifyListeners();
  }

  String get oldPassword => _oldPassword;
  set oldPassword(String value) {
    _oldPassword = value;
  }

  String get newPassword => _newPassword;
  set newPassword(String value) {
    _newPassword = value;
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  ProfileViewModel() {
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    isLoading = true;
    var profile = await AuthRepository().getUserProfile();
    name = profile['name'];
    isLoading = false;
  }

  Future<void> saveProfile(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      isLoading = true;
      await AuthRepository().updateUserProfile(name);
      if (newPassword.isNotEmpty) {
        bool reauthenticated = await AuthRepository().reauthenticateUser(oldPassword);
        if (reauthenticated) {
          await AuthRepository().updateUserPassword(newPassword);
        } else {
          // Handle reauthentication failure
          ScaffoldMessenger.of(_formKey.currentContext!).showSnackBar(
            SnackBar(content: Text('Reauthentication failed. Please check your old password.')),
          );
          isLoading = false;
          return;
        }
      }
      isLoading = false;
      showSuccessDialog(context);
    }
  }

  void showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Profile updated successfully'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
