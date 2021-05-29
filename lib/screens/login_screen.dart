import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Provider Import
import 'package:provider/provider.dart';

// Google Sign In Class
import 'package:todo_list/provider/google_sign_in.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Spacer(),
        Text(
          'Login',
          style: TextStyle(color: Colors.white, fontSize: 40.0),
        ),
        TextButton(
          onPressed: () {
            final provider =
                Provider.of<GoogleSignInProvider>(context, listen: false);
            provider.googleLogin();
          },
          child: Text('Sign Up with Google'),
          style: TextButton.styleFrom(backgroundColor: Colors.white),
        )
      ]),
    );
  }
}
