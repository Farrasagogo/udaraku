// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDD0CLoZFxTtpselgLztPJwH2VpL-IiwuQ',
    appId: '1:50747700132:web:d82ea71f35d2ff73138731',
    messagingSenderId: '50747700132',
    projectId: 'udaraku-9e273',
    authDomain: 'udaraku-9e273.firebaseapp.com',
    databaseURL: 'https://udaraku-9e273-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udaraku-9e273.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD45STpMoqTLEr5SZQYo2v93LK078yTxf4',
    appId: '1:50747700132:android:36711dc4251318d6138731',
    messagingSenderId: '50747700132',
    projectId: 'udaraku-9e273',
    databaseURL: 'https://udaraku-9e273-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udaraku-9e273.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD83rfPAdzfY3xdFAeWxbgeI1QbdvEIDJY',
    appId: '1:50747700132:ios:60d65d0611f9413f138731',
    messagingSenderId: '50747700132',
    projectId: 'udaraku-9e273',
    databaseURL: 'https://udaraku-9e273-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udaraku-9e273.appspot.com',
    iosBundleId: 'com.example.udaraku',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD83rfPAdzfY3xdFAeWxbgeI1QbdvEIDJY',
    appId: '1:50747700132:ios:60d65d0611f9413f138731',
    messagingSenderId: '50747700132',
    projectId: 'udaraku-9e273',
    databaseURL: 'https://udaraku-9e273-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udaraku-9e273.appspot.com',
    iosBundleId: 'com.example.udaraku',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDD0CLoZFxTtpselgLztPJwH2VpL-IiwuQ',
    appId: '1:50747700132:web:543cb8fbe37a3573138731',
    messagingSenderId: '50747700132',
    projectId: 'udaraku-9e273',
    authDomain: 'udaraku-9e273.firebaseapp.com',
    databaseURL: 'https://udaraku-9e273-default-rtdb.asia-southeast1.firebasedatabase.app',
    storageBucket: 'udaraku-9e273.appspot.com',
  );

}