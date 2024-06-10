import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:udaraku/src/features/article/presentation/article_viewmodel.dart';
import 'package:udaraku/src/features/article/presentation/detail_article.dart';
import 'package:udaraku/src/features/home/presentation/view/air_quality_details.dart'; // Ensure you have the necessary imports

class ArticlePage extends StatefulWidget {
  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  int _currentIndex = 3; // Assuming "Article" is the fourth item in the navbar

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ArticleViewModel()..fetchArticles(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Article'),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Consumer<ArticleViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: viewModel.articles.length,
              itemBuilder: (context, index) {
                final article = viewModel.articles[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailArticle(articleId: article.id),
                      ),
                    );
                  },
                  child: buildCard(article.imageUrl, article.title),
                );
              },
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
                if (index == 3) {
                  
                } else if (index == 0) {
                  Navigator.pushReplacementNamed(context, '/home'); // Update accordingly
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

  Widget buildCard(String imagePath, String text) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            height: 200.0, // Set a fixed height for the image
            width: double.infinity, // Make the image take up the full width of the card
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover, // Ensure the image covers the entire area
            ),
          ),
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
