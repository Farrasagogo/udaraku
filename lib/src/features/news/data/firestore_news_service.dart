import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:udaraku/src/features/news/domain/news.dart';

class FirestoreNewsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<News>> fetchNews() async {
    QuerySnapshot snapshot = await _firestore.collection('news').get();
    return snapshot.docs.map((doc) => News.fromFirestore(doc)).toList();
  }
}
