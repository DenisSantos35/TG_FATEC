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
    apiKey: 'AIzaSyCpVg4-lO8bw0Zo9aUO0NFwqqQj_5mvOCQ',
    appId: '1:258029301227:web:55fb1dd97a2b711627fdae',
    messagingSenderId: '258029301227',
    projectId: 'vendastomate-7d706',
    authDomain: 'vendastomate-7d706.firebaseapp.com',
    storageBucket: 'vendastomate-7d706.appspot.com',
    measurementId: 'G-Z3RGM6LLGT',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD0wsON1ZM8hJLcxURysIRrHU4gtj0htog',
    appId: '1:258029301227:android:5774ca74f8831c2727fdae',
    messagingSenderId: '258029301227',
    projectId: 'vendastomate-7d706',
    storageBucket: 'vendastomate-7d706.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA3QgmXAn8kM6Lcv1ig8YHp-a-yLo6DgAI',
    appId: '1:258029301227:ios:3528fdafe713bf3727fdae',
    messagingSenderId: '258029301227',
    projectId: 'vendastomate-7d706',
    storageBucket: 'vendastomate-7d706.appspot.com',
    iosBundleId: 'com.tgfatec.tgFatec',
  );
}