import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:udaraku/src/features/home/presentation/viewmodel/air_quality_viewmodel.dart';

class AirQualityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AirQualityViewModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Hi Faith!'),
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              //backgroundImage: AssetImage('assets/avatar.png'),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.mail_outline, color: Colors.black),
              onPressed: () {
                // Handle mail icon press
              },
            ),
          ],
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
                     // Navigator.push(
                       // context,
                        //MaterialPageRoute(builder: (context) => AirQualityDetails()),
                     // );
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
        width: 160,
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
    );
  }

  String _getStatus(int aqi) {
    if (aqi <= 50) return 'Good';
    if (aqi <= 100) return 'Moderate';
    if (aqi <= 150) return 'Unhealthy for Sensitive Groups';
    if (aqi <= 200) return 'Unhealthy';
    if (aqi <= 300) return 'Very Unhealthy';
    return 'Hazardous';
  }

  Color _getStatusColor(int aqi) {
    if (aqi <= 50) return Colors.green;
    if (aqi <= 100) return Colors.yellow;
    if (aqi <= 150) return Colors.orange;
    if (aqi <= 200) return Colors.red;
    if (aqi <= 300) return Colors.purple;
    return Colors.brown;
  }
}
