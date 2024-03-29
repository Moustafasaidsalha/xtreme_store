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
    apiKey: 'AIzaSyC68BKDGCsdrzXLsPango2P7TFWa9By4PE',
    appId: '1:113453675319:web:5e7d48fed849aa763220b2',
    messagingSenderId: '113453675319',
    projectId: 'xtreme-6e456',
    authDomain: 'xtreme-6e456.firebaseapp.com',
    storageBucket: 'xtreme-6e456.appspot.com',
    measurementId: 'G-FL3EX95NZC',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDJPU5KmaeWkRwtRCnHnKAXB7AcAw6p5ts',
    appId: '1:113453675319:android:2ec58a71fecf6fbc3220b2',
    messagingSenderId: '113453675319',
    projectId: 'xtreme-6e456',
    storageBucket: 'xtreme-6e456.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDGkcRawTbhbZE7GEfEh1So0jyRJUdenmA',
    appId: '1:113453675319:ios:003432cdae7892dd3220b2',
    messagingSenderId: '113453675319',
    projectId: 'xtreme-6e456',
    storageBucket: 'xtreme-6e456.appspot.com',
    iosBundleId: 'com.leapsolutionskw.xtreme',
  );
}
