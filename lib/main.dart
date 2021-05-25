import 'package:flutter/material.dart';

// Import Screen
import 'package:todo_list/screens/list_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ListScreen(),
      theme: ThemeData(
          primarySwatch: Colors.pink, scaffoldBackgroundColor: Colors.black),
    );
  }
}
