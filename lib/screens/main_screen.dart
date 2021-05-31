import 'package:flutter/material.dart';

// Firebase Auth Lib
import 'package:firebase_auth/firebase_auth.dart';

// Import Screens
import 'list_screen.dart';
import 'login_screen.dart';
import 'card_screen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, login) {
          if (login.connectionState == ConnectionState.waiting) {
            return Container(
              child: Text('You have to use a progress bar herer!'),
            );
          } else if (login.hasError) {
            return Container(
              child: Text('Something Went Wrong'),
            );
          } else if (login.hasData) {
            return ListScreen();
          } else {
            return LoginScreen();
          }
        });
  }
}
