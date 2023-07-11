import 'package:firebase/Controller/03PhoneVerifiedWithOtpController/verify_phone_number.dart';
import 'package:flutter/material.dart';

class SendOtpScreen03 extends StatefulWidget {
  const SendOtpScreen03({Key? key}) : super(key: key);

  @override
  State<SendOtpScreen03> createState() => _SendOtpScreen03State();
}

class _SendOtpScreen03State extends State<SendOtpScreen03> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                sendOtp();
              },
              child: const Text("Send OTP"),
            ),
          ],
        ),
      ),
    );
  }
}
