import 'package:flutter/material.dart';
import 'package:udaraku/src/features/home/domain/entities/air_quality.dart';
import 'package:udaraku/src/utils/user_manager.dart';

class AirQualityDetails extends StatelessWidget {
  final AirQuality airQuality;

  AirQualityDetails({required this.airQuality});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.upload, color: Colors.black),
            onPressed: () {
              // Handle upload action
            },
          ),
        ],
      ),
      body: SingleChildScrollView( // Added SingleChildScrollView here
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderCard(),
              SizedBox(height: 16),
              _buildRecommendationCard(),
              SizedBox(height: 16),
              _buildAQICharts(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderCard() {
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
                      Text(airQuality.location, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text('Last Updated: ${airQuality.date}', style: TextStyle(fontSize: 16, color: Colors.grey)),
                    ],
                  ),
                ),
                Flexible(
                  flex: 0,
                  child: Column(
                    children: [
                      Text(_getStatus(airQuality.aqi), style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: _getStatusColor(airQuality.aqi))),
                      SizedBox(height: 8),
                      Image.asset(
                        _getImageAsset(airQuality.aqi),
                        width: 60, // Adjust the width as needed
                        height: 60, // Adjust the height as needed
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            FutureBuilder<String?>(
              future: UserManager().getUserName(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text(
                    'Hi, loading user 👋\nHere is the air quality for ${airQuality.location} today, ${DateTime.now().toString().split(' ')[0]}:',
                    style: TextStyle(fontSize: 18),
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    'Hi, user not found 👋\nHere is the air quality for ${airQuality.location} today, ${DateTime.now().toString().split(' ')[0]}:',
                    style: TextStyle(fontSize: 18),
                  );
                } else {
                  return Text(
                    'Hi, ${snapshot.data ?? 'user'} 👋\nHere is the air quality for ${airQuality.location} today, ${DateTime.now().toString().split(' ')[0]}:',
                    style: TextStyle(fontSize: 18),
                  );
                }
              },
            ),
            SizedBox(height: 16),
            _buildAirQualityDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildRecommendationCard() {
    String recommendation = _getRecommendation(airQuality.aqi);
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

  Widget _buildAirQualityDetails() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildAirQualityDetail('CO2', '${airQuality.aqi} PPM'),
        _buildAirQualityDetail('Humidity', '${airQuality.humidity} %'),
        _buildAirQualityDetail('Temperature', '${airQuality.temperature} ℃'),
      ],
    );
  }

  Widget _buildAQIBox(String text) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.green.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(text, style: TextStyle(fontSize: 16, color: Colors.green)),
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

  Widget _buildAQICharts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('AQI 24 Hours', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text('Chart Placeholder')),
        ),
        SizedBox(height: 16),
        Text('AQI Forward 12 Hours', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        Container(
          height: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(child: Text('Chart Placeholder')),
        ),
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
}
