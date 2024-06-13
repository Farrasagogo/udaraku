import 'package:udaraku/src/features/news/data/firestore_news_service.dart';
import 'package:udaraku/src/features/news/domain/news.dart';

class NewsRepository {
  final FirestoreNewsService _service = FirestoreNewsService();

  Future<List<News>> getNews() {
    return _service.fetchNews();
  }
}
