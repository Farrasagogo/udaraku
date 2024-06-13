import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'profile_viewmodel.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _currentIndex = 4; // Assuming "Profile" is the fifth item in the navbar

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Consumer<ProfileViewModel>(
          builder: (context, viewModel, child) {
            return viewModel.isLoading
                ? Center(child: CircularProgressIndicator())
                : Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Form(
                      key: viewModel.formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            initialValue: viewModel.name,
                            decoration: InputDecoration(labelText: 'Name'),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                            onSaved: (value) => viewModel.name = value!,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Old Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please enter your old password';
                              }
                              return null;
                            },
                            onSaved: (value) => viewModel.oldPassword = value!,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'New Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value!.isNotEmpty && value.length < 6) {
                                return 'Password must be at least 6 characters';
                              }
                              viewModel.newPassword = value!;
                              return null;
                            },
                            onSaved: (value) => viewModel.newPassword = value!,
                          ),
                          SizedBox(height: 16.0),
                          TextFormField(
                            decoration: InputDecoration(labelText: 'Confirm Password'),
                            obscureText: true,
                            validator: (value) {
                              if (value != viewModel.newPassword) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 16.0),
                          ElevatedButton(
                            onPressed: () => viewModel.saveProfile(context),
                            child: Text('Edit Profile'),
                          ),
                        ],
                      ),
                    ),
                  );
          },
        ),
        extendBody: true,
        bottomNavigationBar: Transform.translate(
          offset: const Offset(0, 0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(34),
            ),
            child: FloatingNavbar(
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
              borderRadius: 34,
              backgroundColor: Colors.black,
              selectedBackgroundColor: Colors.transparent,
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white,
              items: [
                _buildNavItem(Icons.home, 'Home', 0),
                _buildNavItem(Icons.newspaper, 'News', 1),
                _buildNavItem(Icons.person_pin, 'GeoLoc', 2),
                _buildNavItem(Icons.book, 'Article', 3),
                _buildNavItem(Icons.person, 'Profile', 4),
              ],
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
                // Add navigation logic for each tab
                if (index == 0) {
                  Navigator.pushReplacementNamed(context, '/home');
                } else if (index == 1) {
                  Navigator.pushReplacementNamed(context, '/news');
                } else if (index == 2) {
                  Navigator.pushReplacementNamed(context, '/geo');
                } else if (index == 3) {
                  Navigator.pushReplacementNamed(context, '/article');
                } else if (index == 4) {
                  // Already in profile, no action needed
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  FloatingNavbarItem _buildNavItem(IconData icon, String title, int index) {
    bool isSelected = _currentIndex == index;
    return FloatingNavbarItem(
      customWidget: Container(
        height: 32,
        width: isSelected ? 70 : 60,
        decoration: BoxDecoration(
          color: isSelected ? Colors.green : Colors.transparent,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Icon(icon, color: Colors.white),
        ),
      ),
      title: title,
    );
  }
}
