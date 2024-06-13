import 'package:flutter/material.dart';
import 'package:udaraku/src/features/news/data/news_repository.dart';
import 'package:udaraku/src/features/news/domain/news.dart';

class NewsViewModel extends ChangeNotifier {
  final NewsRepository _newsRepository = NewsRepository();
  List<News> _news = [];
  bool _isLoading = false;

  List<News> get news => _news;
  bool get isLoading => _isLoading;

  Future<void> fetchNews() async {
    _isLoading = true;
    notifyListeners();
    _news = await _newsRepository.getNews();
    _isLoading = false;
    notifyListeners();
  }
}
