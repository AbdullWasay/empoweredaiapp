import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'home.dart'; // Import the Home screen

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();

    // Check if the user is already logged in when the widget is initialized
    _checkUserLoggedIn();
  }

  Future<void> _checkUserLoggedIn() async {
    User? user = _auth.currentUser;
    if (user != null) {
      // If user is logged in, navigate to Home screen directly
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    }
  }

  Future<void> registerUser() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'username': usernameController.text,
        'password': passwordController.text, // Consider encrypting the password
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => const Home()), // Navigate to Home
      );
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Registration failed")));
    }
  }

  Future<void> loginUser() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      DocumentSnapshot userDoc = await _firestore
          .collection('users')
          .doc(userCredential.user?.uid)
          .get();

      if (userDoc.exists) {
        // Navigate to Home screen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } else {
        // User document doesn't exist, display message
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("User document not found")));
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.message}");
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Login failed: ${e.message}")));
    } catch (e) {
      print("Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("An unexpected error occurred")));
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login / Register')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username (Email)'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: registerUser,
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: loginUser,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
