import 'package:flutter/material.dart';
import 'package:udaraku/src/features/article/domain/article.dart';
import 'package:udaraku/src/features/article/data/article_repository.dart';

class ArticleViewModel extends ChangeNotifier {
  final ArticleRepository _repository = ArticleRepository();
  List<Article> _articles = [];
  Article? _selectedArticle;
  bool _isLoading = false;

  List<Article> get articles => _articles;
  Article? get selectedArticle => _selectedArticle;
  bool get isLoading => _isLoading;

  Future<void> fetchArticles() async {
    _isLoading = true;
    notifyListeners();

    _articles = await _repository.getArticles();
    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchArticleById(String id) async {
    _isLoading = true;
    notifyListeners();

    _selectedArticle = await _repository.getArticleById(id);
    _isLoading = false;
    notifyListeners();
  }
}
