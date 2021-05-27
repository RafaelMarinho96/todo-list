import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

// Import Screen
import 'package:todo_list/screens/list_screen.dart';

// Import widgets
import 'package:todo_list/widgets/loading.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('$snapshot.error'),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loading();
          }
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ListScreen(),
            theme: ThemeData(
                primarySwatch: Colors.pink,
                scaffoldBackgroundColor: Colors.grey[900]),
          );
        });
  }
}
