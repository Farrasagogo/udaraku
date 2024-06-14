import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:udaraku/src/features/geo/presentation/geo_viewmodel.dart';
import 'package:udaraku/src/utils/user_manager.dart';

class GeoScreen extends StatefulWidget {
  @override
  _GeoScreenState createState() => _GeoScreenState();
}

class _GeoScreenState extends State<GeoScreen> {
  int _currentIndex = 2; // Assuming "GeoLoc" is the third item in the navbar

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<GeoViewModel>(context, listen: false).fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'), // replace with the appropriate asset
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Consumer<GeoViewModel>(
          builder: (context, model, child) {
            if (model.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            if (model.errorMessage != null) {
              return Center(child: Text('Error: ${model.errorMessage}'));
            }

            if (model.airQualityData == null) {
              return Center(child: Text('No data available'));
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderCard(model),
                  SizedBox(height: 16),
                  _buildRecommendationCard(model.airQualityData!['aqi']),
                  SizedBox(height: 16),
                  _buildAdditionalRecommendationCard(model.airQualityData!['aqi']),
                ],
              ),
            );
          },
        ),
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
              switch (index) {
                case 0:
                  Navigator.pushReplacementNamed(context, '/home');
                  break;
                case 1:
                  Navigator.pushReplacementNamed(context, '/news');
                  break;
                case 2:
                  // Do nothing since we are already on the GeoLoc screen
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/article');
                  break;
                case 4:
                  Navigator.pushReplacementNamed(context, '/profile');
                  break;
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard(GeoViewModel model) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        model.locality ?? 'Location',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Latitude: ${model.latitude}',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      Text(
                        'Longitude: ${model.longitude}',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        _getStatus(model.airQualityData!['aqi']),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(model.airQualityData!['aqi']),
                        ),
                      ),
                      SizedBox(height: 8),
                      Image.asset(
                        _getImageAsset(model.airQualityData!['aqi']),
                        width: 60,
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Hi ${model.userName ?? 'There'},\nHere is the air quality for ${model.locality ?? 'your location'} today, ${DateTime.now().toString().split(' ')[0]}:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            _buildAirQualityDetails(model),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard(int aqi) {
    String recommendation = _getRecommendation(aqi);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendation',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              recommendation,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdditionalRecommendationCard(int aqi) {
    String additionalRecommendation = _getAdditionalRecommendation(aqi);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recommendation Activities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              additionalRecommendation,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAirQualityDetails(GeoViewModel model) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAirQualityDetail('AQI', '${model.airQualityData!['aqi']}'),
        _buildAirQualityDetail('Humidity', '${model.airQualityData!['hum']} %'),
        _buildAirQualityDetail('Temperature', '${model.airQualityData!['temp']} ℃'),
      ],
    );
  }

  Widget _buildAirQualityDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  String _getRecommendation(int ppm) {
    if (ppm <= 700) return 'Air quality is good. You can go outside and enjoy your day!';
    if (ppm <= 1000) return 'Air quality is moderate. It\'s okay to go outside, but consider limiting prolonged outdoor exertion.';
    if (ppm <= 1500) return 'Air quality is unhealthy for sensitive groups. Sensitive individuals should limit outdoor exertion.';
    if (ppm <= 2500) return 'Air quality is unhealthy. Everyone should reduce prolonged or heavy exertion outdoors.';
    if (ppm <= 5000) return 'Air quality is very unhealthy. Avoid outdoor activities and stay indoors.';
    return 'Air quality is hazardous. Remain indoors and keep windows and doors closed.';
  }
  String _getAdditionalRecommendation(int ppm) {
    if (ppm <= 700) return 'Take advantage of the fresh air by exercising outdoors.';
    if (ppm <= 1000) return 'Consider taking breaks indoors if you start feeling discomfort.';
    if (ppm <= 1500) return 'Limit outdoor activities, especially if you have respiratory issues.';
    if (ppm <= 2500) return 'Try to remain indoors and keep windows closed to avoid poor air quality.';
    if (ppm <= 5000) return 'Use air purifiers indoors and avoid going outside unless necessary.';
    return 'Seek medical attention if you experience severe symptoms due to poor air quality.';
  }

  String _getStatus(int ppm) {
    if (ppm <= 700) return 'Good';
    if (ppm <= 1000) return 'Moderate';
    if (ppm <= 1500) return 'Unhealthy for Sensitive Groups';
    if (ppm <= 2500) return 'Unhealthy';
    if (ppm <= 5000) return 'Very Unhealthy';
    return 'Hazardous';
  }

  Color _getStatusColor(int ppm) {
    if (ppm <= 700) return Colors.green;
    if (ppm <= 1000) return Colors.yellow;
    if (ppm <= 1500) return Colors.orange;
    if (ppm <= 2500) return Colors.red;
    if (ppm <= 5000) return Colors.purple;
    return Colors.brown;
  }

  String _getImageAsset(int ppm) {
    if (ppm <= 700) {
      return 'assets/images/good_air_quality.png';
    } else if (ppm <= 1000) {
      return 'assets/images/moderate_air_quality.png';
    } else if (ppm <= 1500) {
      return 'assets/images/unhealthy_sensitive_groups.png';
    } else if (ppm <= 2500) {
      return 'assets/images/unhealthy_air_quality.png';
    } else if (ppm <= 5000) {
      return 'assets/images/very_unhealthy_air_quality.png';
    } else {
      return 'assets/images/hazardous_air_quality.png';
    }
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
