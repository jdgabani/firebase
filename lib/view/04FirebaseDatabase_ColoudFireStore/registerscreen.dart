// ignore_for_file: use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase/Controller/commontextformfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../02UserLoginWithFirebaseTask/login_screen.dart';
import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  CollectionReference users = FirebaseFirestore.instance.collection('user');
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
        child: Column(
          children: [
            CommonTextFomField(
              labelText: "Enter name",
              controller: nameController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            CommonTextFomField(
              labelText: "Enter username",
              controller: usernameController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            CommonTextFomField(
              labelText: "Enter gender",
              controller: genderController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            CommonTextFomField(
              labelText: "Enter email",
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 20),
            CommonTextFomField(
              labelText: "Enter password",
              controller: passwordController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),
            loading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: () async {
                      try {
                        setState(() {
                          loading = true;
                        });
                        UserCredential credential =
                            await auth.createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        setState(() {
                          loading = false;
                        });
                        print('EMAIL ${credential.user!.email}');
                        print('UID ${credential.user!.uid}');

                        users.doc(credential.user!.uid).set({
                          "name": nameController.text,
                          "username": usernameController.text,
                          "gender": genderController.text,
                          "emailId": emailController.text,
                          "password": passwordController.text,
                        });

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
                    child: const Text('Register'),
                  ),
            Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginScreen(),
                          ));
                    },
                    child: const Text("Login"))),
          ],
        ),
      ),
    );
  }
}
