import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screens/signin.dart'; // Import the SignIn screen
import 'firebase_options.dart'; // Import the firebase_options.dart

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Initialize with Android config
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Empowered AI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MySplashScreen(),
        '/signin': (context) => const SignIn(),
        // Define other routes here (e.g., home page)
      },
    );
  }
}

class MySplashScreen extends StatelessWidget {
  const MySplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(
          context, '/signin'); // Navigate to the SignIn screen
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(child: Text('Loading...')), // Your splash screen content
    );
  }
}
