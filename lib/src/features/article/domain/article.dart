import 'package:cloud_firestore/cloud_firestore.dart';

class Article {
  final String id;
  final String title;
  final String imageUrl;
  final String content;
  final String writer;
  final String type;
  final String date;

  Article({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.content,
    required this.writer,
    required this.type,
    required this.date,
  });

  factory Article.fromFirestore(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return Article(
      id: doc.id,
      title: data['title'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      content: data['content'] ?? '',
      writer: data['writer'] ?? '',
      type: data['type'] ?? '',
      date: data['date'] ?? '',
    );
  }
}
