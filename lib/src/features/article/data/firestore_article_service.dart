import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udaraku/src/features/article/domain/article.dart';

class FirestoreArticleService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Article>> fetchArticles() async {
    QuerySnapshot snapshot = await _firestore.collection('article').get();
    return snapshot.docs.map((doc) => Article.fromFirestore(doc)).toList();
  }

  Future<Article> fetchArticleById(String id) async {
    DocumentSnapshot doc = await _firestore.collection('article').doc(id).get();
    return Article.fromFirestore(doc);
  }
}
