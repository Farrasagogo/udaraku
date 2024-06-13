import 'package:flutter/material.dart';
import 'package:udaraku/src/features/article/presentation/article_page.dart';
import 'package:udaraku/src/features/auth/presentation/login/login_page.dart';
import 'package:udaraku/src/features/auth/presentation/profile/profile_page.dart';
import 'package:udaraku/src/features/auth/presentation/register/register_page.dart';
import 'package:udaraku/src/features/geo/presentation/geo_view.dart';
import 'package:udaraku/src/features/home/presentation/view/air_quality_screen.dart';
import 'package:udaraku/src/features/news/presentation/news_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => LoginPage(),
  '/register': (context) => RegisterPage(),
  '/home': (context) => AirQualityScreen(),
  '/article': (context) => ArticlePage(),
  '/news': (context) => NewsPage(),
  '/geo': (context) => GeoScreen(),
  '/profile': (context) => ProfilePage(),
};