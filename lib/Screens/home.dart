import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'signin.dart'; // Import the SignIn screen

class Home extends StatelessWidget {
  const Home({super.key});

  // Logout function
  Future<void> logoutUser(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Log the user out

      // Schedule the navigation to the SignIn screen after the current frame is completed
      WidgetsBinding.instance!.addPostFrameCallback((_) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const SignIn()),
        );
      });
    } catch (e) {
      print("Error logging out: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Logout failed")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Welcome to Home Screen!'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => logoutUser(context), // Call logout function
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
