import 'package:flutter/material.dart';
import 'package:udaraku/src/features/auth/presentation/login/login_page.dart';
import 'package:udaraku/src/features/auth/presentation/register/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:udaraku/src/features/home/presentation/view/air_quality_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Udaraku2',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/home': (context) => AirQualityScreen(),
        // Add more routes here
      },
    );
  }
}

