import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udaraku/src/features/geo/data/geocoding_service.dart';
import 'package:udaraku/src/features/geo/presentation/geo_viewmodel.dart';
import 'package:udaraku/src/features/geo/data/geo_repositories.dart'; 
import 'package:udaraku/src/utils/user_manager.dart'; 
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

class GeoScreen extends StatefulWidget {
  @override
  _GeoScreenState createState() => _GeoScreenState();
}

class _GeoScreenState extends State<GeoScreen> {
  int _currentIndex = 2; // Assuming "GeoLoc" is the third item in the navbar

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => GeoViewModel(UserManager(), AirQualityService(), GeocodingService()), 
      child: Consumer<GeoViewModel>(
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(title: Text('GeoLoc')),
            body: FutureBuilder(
              future: model.fetchUserData(),
              builder: (context, snapshot) {
                // Check if an error message is present
                if (model.errorMessage != null) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Latitude: ${model.latitude}'),
                          Text('Longitude: ${model.longitude}'),
                          Text('Error: ${model.errorMessage!}'),
                        ],
                      ),
                    ),
                  );
                }
                
                // Check if data is still loading
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } 

                // Check if no data is available
                if (model.airQualityData == null) {
                  return Center(child: Text('No data available'));
                }

                // Display data if everything is available
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hello, ${model.userName}'),
                      Text('Latitude: ${model.latitude}'),
                      Text('Longitude: ${model.longitude}'),
                      Text('Locality: ${model.locality}'),
                      Text('AQI: ${model.airQualityData!['aqi']}'),
                      Text('Humidity: ${model.airQualityData!['hum']}'),
                      Text('Temperature: ${model.airQualityData!['temp']}'),
                    ],
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
                    if (index == 1) {
                      Navigator.pushReplacementNamed(context, '/news'); // Update accordingly
                    } else if (index == 0) {
                      Navigator.pushReplacementNamed(context, '/home'); // Update accordingly
                    } else if (index == 3) {
                      Navigator.pushReplacementNamed(context, '/article'); // Update accordingly
                    } else if (index == 4) {
                      Navigator.pushReplacementNamed(context, '/profile'); // Update accordingly
                    }
                  },
                ),
              ),
            ),
          );
        },
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
