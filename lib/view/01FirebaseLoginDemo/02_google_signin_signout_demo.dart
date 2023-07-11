import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInSignOutDemo extends StatefulWidget {
  const GoogleSignInSignOutDemo({Key? key}) : super(key: key);

  @override
  State<GoogleSignInSignOutDemo> createState() =>
      _GoogleSignInSignOutDemoState();
}

class _GoogleSignInSignOutDemoState extends State<GoogleSignInSignOutDemo> {
  bool isSignIn = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  GoogleSignIn googleSignIn = GoogleSignIn();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Sign In & Sign Out"),
      ),
      body: isSignIn
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    googleSignIn.currentUser!.photoUrl.toString(),
                    height: 150,
                    width: 150,
                  ),
                  Text(googleSignIn.currentUser!.displayName.toString()),
                  Text(googleSignIn.currentUser!.email.toString()),
                  OutlinedButton(
                    onPressed: () {
                      SignOut();
                    },
                    child: Text("Google SignOut"),
                  ),
                ],
              ),
            )
          : Center(
              child: OutlinedButton(
                onPressed: () {
                  SignIn();
                },
                child: Text("Google SignIn"),
              ),
            ),
    );
  }

  SignIn() async {
    try {
      await googleSignIn.signIn();
      setState(() {
        isSignIn = true;
      });
    } catch (e) {
      print(e);
    }
  }

  SignOut() {
    googleSignIn.signOut();
    setState(() {
      isSignIn = false;
    });
  }
}
