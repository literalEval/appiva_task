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
    apiKey: 'AIzaSyAD3nU08ri5TArFa7QUhp6XwGd_8Ayv1Ig',
    appId: '1:706528569196:web:e3e9143df4bc35694bb549',
    messagingSenderId: '706528569196',
    projectId: 'appiva-task',
    authDomain: 'appiva-task.firebaseapp.com',
    storageBucket: 'appiva-task.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDwrByg81TJMcvE57HFCncY2fzIED9BaCA',
    appId: '1:706528569196:android:d2973f209ad5fdd24bb549',
    messagingSenderId: '706528569196',
    projectId: 'appiva-task',
    storageBucket: 'appiva-task.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA62-zs9kNSc5FhAhQp113ahSRHxSxZrts',
    appId: '1:706528569196:ios:96430eeb2ef028b24bb549',
    messagingSenderId: '706528569196',
    projectId: 'appiva-task',
    storageBucket: 'appiva-task.appspot.com',
    iosClientId: '706528569196-igb9oddp1suf4hght1rpu4gkbfdefpc9.apps.googleusercontent.com',
    iosBundleId: 'com.cheems.appivaTask',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA62-zs9kNSc5FhAhQp113ahSRHxSxZrts',
    appId: '1:706528569196:ios:96430eeb2ef028b24bb549',
    messagingSenderId: '706528569196',
    projectId: 'appiva-task',
    storageBucket: 'appiva-task.appspot.com',
    iosClientId: '706528569196-igb9oddp1suf4hght1rpu4gkbfdefpc9.apps.googleusercontent.com',
    iosBundleId: 'com.cheems.appivaTask',
  );
}
