import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:udaraku/src/features/home/presentation/viewmodel/air_quality_viewmodel.dart';
import 'package:udaraku/src/features/home/presentation/view/air_quality_details.dart';


class AirQualityScreen extends StatefulWidget {
  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AirQualityViewModel(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Consumer<AirQualityViewModel>(
            builder: (context, viewModel, child) {
              return Text('Hi ${viewModel.userName ?? 'There'}!');
            },
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user.png'), // replace with the appropriate asset
            ),
          ),
        ),
        body: Consumer<AirQualityViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.airQualities == null) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView(
              padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
              children: [
                SizedBox(height: 16),
                const Text(
                  'Air Quality Jember',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                ...viewModel.airQualities!.map((airQuality) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AirQualityDetails(airQuality: airQuality)),
                      );
                    },
                    child: _buildFavoriteCard(
                      airQuality.location,
                      _getStatus(airQuality.aqi),
                      airQuality.aqi,
                      _getStatusColor(airQuality.aqi),
                    ),
                  );
                }).toList(),
              ],
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
                if (index == 3) {
                 Navigator.pushReplacementNamed(context, '/article');
                } else if (index == 1) {
                Navigator.pushReplacementNamed(context, '/news');
                } else if (index == 2) {
                  Navigator.pushReplacementNamed(context, '/geo'); // Update accordingly
                }
                else if (index == 4) {
                  Navigator.pushReplacementNamed(context, '/profile'); // Update accordingly
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFavoriteCard(String location, String status, int aqi, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        width: double.infinity,
        child: Row(
          children: [
            SizedBox(width: 16), // Add spacing between the image and text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    status,
                    style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    '$aqi PPM',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            _buildImageBasedOnPMM(aqi),
          ],
        ),
      ),
    );
  }

Widget _buildImageBasedOnPMM(int ppm) {
    if (ppm <= 700) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Image.asset('assets/images/good_air_quality.png'),
      );
    } else if (ppm <= 1000) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Image.asset('assets/images/moderate_air_quality.png'),
      );
    } else if (ppm <= 1500) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Image.asset('assets/images/unhealthy_sensitive_groups.png'),
      );
    } else if (ppm <= 2500) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Image.asset('assets/images/unhealthy_air_quality.png'),
      );
    } else if (ppm <= 5000) {
      return SizedBox(
        width: 60,
        height: 60,
        child: Image.asset('assets/images/very_unhealthy_air_quality.png'),
      );
    } else {
      return SizedBox(
        width: 60,
        height: 60,
        child: Image.asset('assets/images/hazardous_air_quality.png'),
      );
    }
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