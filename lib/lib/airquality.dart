import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AirQualityScreen(),
    );
  }
}

class AirQualityScreen extends StatefulWidget {
  @override
  _AirQualityScreenState createState() => _AirQualityScreenState();
}

class _AirQualityScreenState extends State<AirQualityScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Hi Faith!'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/avatar.png'), // replace with the appropriate asset
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
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 16, 16, 90),
        children: [
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sumbersari',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Good',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '48 AQI',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        '10 PM2.5',
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Last Updated 07:52, 25 Aug 2023',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 16),
          const Text(
            'Favorite',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AirQualityDetails()),
                    );
                  },
                  child: _buildFavoriteCard('Sumbersari', 'Good', 24, Colors.green),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AirQualityDetails()),
                    );
                  },
                  child: _buildFavoriteCard('Arjasa', 'Moderate', 78, Colors.orange),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AirQualityDetails()),
                    );
                  },
                  child: _buildFavoriteCard('Patrang', 'Unhealthy for Sensitive Groups', 105, Colors.redAccent),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AirQualityDetails()),
                    );
                  },
                  child: _buildFavoriteCard('Puger', 'Unhealthy', 161, Colors.red),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
      extendBody: false,
      bottomNavigationBar: Transform.translate(
        offset: const Offset(0, -40),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(34),
          ),
          child: FloatingNavbar(
            borderRadius: 34,
            backgroundColor: Colors.black,
            selectedBackgroundColor: Colors.transparent,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            items: [
              _buildNavItem(Icons.home, 'Home', 0),
              _buildNavItem(Icons.search, 'Search', 1),
              _buildNavItem(Icons.bar_chart, 'Analysis', 2),
              _buildNavItem(Icons.store, 'Store', 3),
              _buildNavItem(Icons.person, 'Profile', 4),
            ],
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
            },
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
              '$aqi AQI',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  FloatingNavbarItem _buildNavItem(IconData icon, String title, int index) {
    bool isSelected = _currentIndex == index;
    return FloatingNavbarItem(
      customWidget: Container(
        height: 40,
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

class AirQualityDetails extends StatelessWidget {
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeaderCard(),
            SizedBox(height: 16),
            _buildAQICharts(),
          ],
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
                    Text('Sumbersari', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                    Text('Last Updated 07:52, 25 Aug 2023', style: TextStyle(fontSize: 16, color: Colors.grey)),
                  ],
                ),
              ),
              Flexible(
                flex: 0,
                child: Column(
                  children: [
                    Text('Good', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildAQIBox('48 AQI'),
                        _buildAQIBox('10 PM2.5'),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildGreeting(),
          SizedBox(height: 16),
          _buildAirQualityDetails(),
        ],
      ),
    ),
  );
}

Widget _buildGreeting() {
  return Text(
    'Hi, Muhammad Dani 👋\nHere is the air quality for Cakung region today,\nJuly 25th, 2023:',
    style: TextStyle(fontSize: 18),
  );
}

Widget _buildAirQualityDetails() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      _buildAirQualityDetail('PM1', '21 µg/m³'),
      _buildAirQualityDetail('PM10', '40 µg/m³'),
      _buildAirQualityDetail('Cloudiness', '86 %'),
      _buildAirQualityDetail('Temperature', '26 ℃'),
    ],
  );
}

// ... (other methods remain the same)
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
}