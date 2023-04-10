// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCLQpYHH-SsCYt3-sa8GRYFo6GC4NBRxXY',
    appId: '1:181903883226:web:f05d64f207c97dddd11ee3',
    messagingSenderId: '181903883226',
    projectId: 'equine-ai',
    authDomain: 'equine-ai.firebaseapp.com',
    storageBucket: 'equine-ai.appspot.com',
    measurementId: 'G-F27GX1XR7P',
    databaseURL: "https://equine-ai-default-rtdb.firebaseio.com/",
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAWE7F3v9RU8Uzr6U9HegFxKc3-qgfXU2E',
    appId: '1:181903883226:android:62be5b49601c3a1ed11ee3',
    messagingSenderId: '181903883226',
    projectId: 'equine-ai',
    storageBucket: 'equine-ai.appspot.com',
    databaseURL: "https://equine-ai-default-rtdb.firebaseio.com/",
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDhLGKQs0fDBaf-pSRtqknsk0xBsFYyMIM',
    appId: '1:181903883226:ios:8035a7e83674847ad11ee3',
    messagingSenderId: '181903883226',
    projectId: 'equine-ai',
    storageBucket: 'equine-ai.appspot.com',
    iosClientId: '181903883226-bqtdptltc7o4thh5ambjp8kblkpilfjk.apps.googleusercontent.com',
    iosBundleId: 'com.example.equineAi',
    databaseURL: "https://equine-ai-default-rtdb.firebaseio.com/",
  );
}
