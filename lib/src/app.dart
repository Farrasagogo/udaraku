import 'package:flutter/material.dart';
import 'package:udaraku/src/features/auth/presentation/login/login_page.dart';
import 'package:udaraku/src/features/auth/presentation/register/register_page.dart';

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
        // Add more routes here
      },
    );
  }
}
