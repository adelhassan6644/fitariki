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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAA6_oQVJoAUiQfGb7aU4MRnkog14w7rPU',
    appId: '1:105813324547:web:668972909f473f2d90af36',
    messagingSenderId: '105813324547',
    projectId: 'fitariki-46646',
    authDomain: 'fitariki-46646.firebaseapp.com',
    storageBucket: 'fitariki-46646.appspot.com',
    measurementId: 'G-QQK112HHXZ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAOzDx7xIAd_Hdf0GRosngBPeJj3MpUXoI',
    appId: '1:105813324547:android:d322d9156015e1f690af36',
    messagingSenderId: '105813324547',
    projectId: 'fitariki-46646',
    storageBucket: 'fitariki-46646.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDuc5q2UyvotvNUmVek3e_o9KhpCt2chdI',
    appId: '1:105813324547:ios:6c4a322ce14cd59090af36',
    messagingSenderId: '105813324547',
    projectId: 'fitariki-46646',
    storageBucket: 'fitariki-46646.appspot.com',
    iosClientId: '105813324547-ka9cb59fajvrip5v711qqhv3ieof52g4.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitariki',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDuc5q2UyvotvNUmVek3e_o9KhpCt2chdI',
    appId: '1:105813324547:ios:6c4a322ce14cd59090af36',
    messagingSenderId: '105813324547',
    projectId: 'fitariki-46646',
    storageBucket: 'fitariki-46646.appspot.com',
    iosClientId: '105813324547-ka9cb59fajvrip5v711qqhv3ieof52g4.apps.googleusercontent.com',
    iosBundleId: 'com.example.fitariki',
  );
}
