// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show TargetPlatform, defaultTargetPlatform, kIsWeb;

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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      // ignore: no_default_cases
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    databaseURL: 'https://easeops-40c4d-default-rtdb.firebaseio.com',
    apiKey: 'AIzaSyCxUUonNRJL9le29vBkxMabvPRNC5ngIgA',
    authDomain: 'easeops-40c4d.firebaseapp.com',
    projectId: 'easeops-40c4d',
    storageBucket: 'easeops-40c4d.appspot.com',
    messagingSenderId: '492708648319',
    appId: '1:492708648319:web:2e8bdaab21e0b00019364a',
    measurementId: 'G-EV9TC86822',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAF9QBOPwN9ZLgP1lKQrPOwWroT1ecGmtU',
    appId: '1:492708648319:android:7ab80eba0ec06ffa19364a',
    messagingSenderId: '492708648319',
    projectId: 'easeops-40c4d',
    databaseURL: 'https://easeops-40c4d-default-rtdb.firebaseio.com',
    storageBucket: 'easeops-40c4d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB0ZYCe9aQxhTJLebwiM0WFBj32D9NQMfg',
    appId: '1:492708648319:ios:3ceb6da14f50959419364a',
    messagingSenderId: '492708648319',
    projectId: 'easeops-40c4d',
    databaseURL: 'https://easeops-40c4d-default-rtdb.firebaseio.com',
    storageBucket: 'easeops-40c4d.appspot.com',
    iosBundleId: 'com.easeops.easeops',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBjDYXMvfmvAYUMNQGBbUHyujHxWnzonJs',
    appId: '1:182515679697:ios:65e15cf40939b5144da0f0',
    messagingSenderId: '492708648319',
    projectId: 'easeops-40c4d',
    databaseURL: 'https://easeops-40c4d-default-rtdb.firebaseio.com',
    storageBucket: 'easeops-40c4d.appspot.com',
    iosBundleId: 'com.easeops.easeops.RunnerTests',
  );
}
