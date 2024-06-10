import 'package:cloud_firestore/cloud_firestore.dart';

class News {
  final String id;
  final String title;
  final String imageUrl;
  final String url;

  News({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.url,
  });

  factory News.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map;
    return News(
      id: doc.id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      url: data['url'] ?? '',
    );
  }
}
