import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:udaraku/src/routing/route.dart'; // Import the routes file
import 'package:udaraku/src/features/geo/presentation/geo_viewmodel.dart';
import 'package:udaraku/src/features/geo/data/geocoding_service.dart';
import 'package:udaraku/src/features/geo/data/geo_repositories.dart';
import 'package:udaraku/src/utils/user_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GeoViewModel(UserManager(), AirQualityService(), GeocodingService()),
        ),
        // Add other providers if needed
      ],
      child: MaterialApp(
        title: 'Udaraku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/',
        routes: routes, // Pass the routes map from routes.dart
      ),
    );
  }
}
