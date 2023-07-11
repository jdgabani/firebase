import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'logout_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final box1 = GetStorage();
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            UserCredential credential =
                await auth.createUserWithEmailAndPassword(
                    email: 'abc@gmail.com', password: '123456');
            print('${credential.user!.email}');
            print('${credential.user!.uid}');
            box1.write(
              'userid',
              '${credential.user!.uid}',
            );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LogoutScreen(),
              ),
            );
          },
          child: Text("Login"),
        ),
      ),
    );
  }
}
