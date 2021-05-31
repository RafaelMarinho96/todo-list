import 'package:flutter/material.dart';

// Provider Import
import 'package:provider/provider.dart';

// Firebase Auth Lib
import 'package:firebase_auth/firebase_auth.dart';

// Google Sign In Class
import 'package:todo_list/provider/google_sign_in.dart';

class HeadingWidget extends StatelessWidget {
  final String? title;
  final bool? enableToBack;

  HeadingWidget({this.title, this.enableToBack = false});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Row(children: [
      _enableBackButton(enableToBack, context),
      _getText(title),
      Spacer(),
      TextButton(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            'Sign out',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15.0,
            ),
          ),
        ),
      ),
      CircleAvatar(
        backgroundImage: NetworkImage(user.photoURL!),
      ),
      /* Text(user.displayName!) */
    ]);
  }

  _getText(title) {
    if (title != null) {
      return Text(
        title,
        style: TextStyle(
            fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.white),
      );
    } else {
      return Container();
    }
  }

  _enableBackButton(enableToBack, context) {
    if (enableToBack == true) {
      return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 22,
        ),
      );
    } else {
      return Container();
    }
  }
}
