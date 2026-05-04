import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart' show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static final FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBshBZZUV5BkVH5T6xhR7zoD_qYAltvvhg',
    appId: '1:820364335620:web:09c098180624f9f5777351',
    messagingSenderId: '820364335620',
    projectId: 'campuseventsandtimetable-396e5',
    authDomain: 'campuseventsandtimetable-396e5.firebaseapp.com',
    databaseURL: 'https://campuseventsandtimetable-396e5-default-rtdb.firebaseio.com',
    storageBucket: 'campuseventsandtimetable-396e5.firebasestorage.app',
    measurementId: 'G-XXXXXXXXXX',
  );

  static final FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBshBZZUV5BkVH5T6xhR7zoD_qYAltvvhg',
    appId: '1:820364335620:android:09c098180624f9f5777351',
    messagingSenderId: '820364335620',
    projectId: 'campuseventsandtimetable-396e5',
    databaseURL: 'https://campuseventsandtimetable-396e5-default-rtdb.firebaseio.com',
    storageBucket: 'campuseventsandtimetable-396e5.firebasestorage.app',
  );

  static final FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBshBZZUV5BkVH5T6xhR7zoD_qYAltvvhg',
    appId: '1:820364335620:ios:09c098180624f9f5777351',
    messagingSenderId: '820364335620',
    projectId: 'campuseventsandtimetable-396e5',
    databaseURL: 'https://campuseventsandtimetable-396e5-default-rtdb.firebaseio.com',
    storageBucket: 'campuseventsandtimetable-396e5.firebasestorage.app',
    iosBundleId: 'com.example.campuseventsandtimetables',
  );

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
          'DefaultFirebaseOptions have not been configured for macOS - '
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
}
