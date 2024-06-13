import 'package:udaraku/src/features/article/domain/article.dart';
import 'package:udaraku/src/features/article/data/firestore_article_service.dart';

class ArticleRepository {
  final FirestoreArticleService _service = FirestoreArticleService();

  Future<List<Article>> getArticles() {
    return _service.fetchArticles();
  }

  Future<Article> getArticleById(String id) {
    return _service.fetchArticleById(id);
  }
}
