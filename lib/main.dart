import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Firebase Imports
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_list/provider/google_sign_in.dart';

// Main Screen Import
import 'package:todo_list/screens/splash_screen.dart';

import 'package:google_fonts/google_fonts.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GoogleSignInProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Colors.pink,
              textTheme:
                  GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
              scaffoldBackgroundColor: Color(0xff151515)),
          home: SplashScreen()),
    );
  }
}
