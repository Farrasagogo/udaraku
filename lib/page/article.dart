import 'package:flutter/material.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:udaraku2/page/airquality.dart';
import 'package:udaraku2/page/detailarticle.dart';





class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Article'), // Set the app bar title here
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
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailArticle()),
              );
            },
            child: buildCard(
              'assets/image1.png',
              'Penyebab polusi udara di Kota Kota besar di Indonesia',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailArticle()),
              );
            },
            child: buildCard(
              'assets/image2.png',
              'Solusi untuk mengurangi polusi udara',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DetailArticle()),
              );
            },
            child: buildCard(
              'assets/image3.png',
              'Pengaruh polusi udara terhadap kesehatan manusia',
            ),
          ),
        ],
      ),
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
              _buildNavItem(Icons.book, 'Article', 3),
              _buildNavItem(Icons.person, 'Profile', 4),
            ],
            currentIndex: _currentIndex,
            onTap: (int index) {
              setState(() {
                _currentIndex = index;
              });
              if (index == 3) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArticlePage()),
                );
              } else if (index == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AirQualityScreen()),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget buildCard(String imagePath, String text) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Image.asset(imagePath),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            ),
          ),
        ],
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