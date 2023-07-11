// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/view/04FirebaseDatabase_ColoudFireStore/home_screen.dart';
import 'package:firebase/view/04FirebaseDatabase_ColoudFireStore/registerscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool loading = false;
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Enter Email",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: "Enter Password",
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 40),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          loading = true;
                        });
                        UserCredential credential =
                            await auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        setState(() {
                          loading = false;
                        });
                        print('EMAIL ${credential.user!.email}');
                        print('UID ${credential.user!.uid}');
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  HomeScreen(userID: credential.user!.uid),
                            ));
                      } on FirebaseAuthException catch (e) {
                        print("ERROR${e.code}");
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("${e.message}")));
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: const Text('Login'),
                  ),
            ElevatedButton(
              onPressed: () async {
                GoogleSignInAccount? account = await googleSignIn.signIn();

                GoogleSignInAuthentication authentication =
                    await account!.authentication;

                AuthCredential credentials = GoogleAuthProvider.credential(
                    accessToken: authentication.accessToken,
                    idToken: authentication.idToken);

                UserCredential credential =
                    await auth.signInWithCredential(credentials);

                print('EMAIL ${credential.user!.email}');
                print('UID ${credential.user!.uid}');
                print('NAME ${credential.user!.displayName}');
                print('PHOTO ${credential.user!.photoURL}');
                users.doc(credential.user!.uid).set({
                  "name": credential.user!.displayName,
                  "emailId": credential.user!.email,
                  "profilePhoto": credential.user!.photoURL,
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          HomeScreen(userID: credential.user!.uid),
                    ));
              },
              child: const Text('LOGIN WITH GOOGLE'),
            ),
            ElevatedButton(
              onPressed: () async {
                await googleSignIn.signOut();
              },
              child: const Text('OUT'),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RegisterScreen(),
                          ));
                    },
                    child: const Text("SignIn"))),
          ],
        ),
      ),
    );
  }
}
