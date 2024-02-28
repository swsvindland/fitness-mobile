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
    apiKey: 'AIzaSyDyhBV3ZqAez69uItQBeDtBae190nAzl7I',
    appId: '1:399751443280:web:20a18f9c589a2ba4443255',
    messagingSenderId: '399751443280',
    projectId: 'lifttrack-92082',
    authDomain: 'lifttrack-92082.firebaseapp.com',
    storageBucket: 'lifttrack-92082.appspot.com',
    measurementId: 'G-WDF7BLSVGQ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC7Yl2f3Z0sl030A2Xzv3oTzb0lGPQw2VE',
    appId: '1:399751443280:android:42e94e51adb8e08a443255',
    messagingSenderId: '399751443280',
    projectId: 'lifttrack-92082',
    storageBucket: 'lifttrack-92082.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANHX9AW-r43rZiT-7kmHUmd-HCmPd2w_w',
    appId: '1:399751443280:ios:c3c6cae32befcca3443255',
    messagingSenderId: '399751443280',
    projectId: 'lifttrack-92082',
    storageBucket: 'lifttrack-92082.appspot.com',
    iosBundleId: 'com.svindland.liftTrack',
  );
}
