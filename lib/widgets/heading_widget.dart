import 'package:flutter/material.dart';

// Provider Import
import 'package:provider/provider.dart';

// Firebase Auth Lib
import 'package:firebase_auth/firebase_auth.dart';

// Google Sign In Class
import 'package:todo_list/provider/google_sign_in.dart';

class HeadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Row(children: [
      Text(
        'Tarefas',
        style: TextStyle(
            fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      Spacer(),
      TextButton(
        onPressed: () {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.logout();
        },
        child: Text('Sign out'),
      ),
      CircleAvatar(
        backgroundImage: NetworkImage(user.photoURL!),
      ),
      /* Text(user.displayName!) */
    ]);
  }
}
