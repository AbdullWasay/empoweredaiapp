import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'; // Import this for platform checks

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    // Since you're only working with Android, we can check for Android platform here
    if (defaultTargetPlatform == TargetPlatform.android) {
      return FirebaseOptions(
        apiKey: 'AIzaSyCbs9QjtN8YwniJISLzO-ZhMiv_fDjB7LY',
        appId: '1:228875165779:android:c64e0781e7f3604c6c26a6',
        messagingSenderId: '228875165779',
        projectId: 'empoweredai-e9c94',
        storageBucket: 'empoweredai-e9c94.firebasestorage.app',
        androidClientId:
            '1:228875165779:android:c64e0781e7f3604c6c26a6', // Your Android client ID
        iosClientId: '', // You can leave it empty or fill in if needed for iOS
        databaseURL:
            '', // Optional, fill if you're using Firebase Realtime Database
      );
    } else {
      throw UnsupportedError(
          'This Firebase configuration is only supported on Android.');
    }
  }
}
