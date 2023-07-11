import 'package:firebase/Controller/03PhoneVerifiedWithOtpController/verify_phone_number.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Controller/03PhoneVerifiedWithOtpController/variable.dart';

class ResendOtpScreen03 extends StatefulWidget {
  const ResendOtpScreen03({Key? key, this.id, this.resend}) : super(key: key);
  final id;
  final resend;

  @override
  State<ResendOtpScreen03> createState() => _ResendOtpScreen03State();
}

class _ResendOtpScreen03State extends State<ResendOtpScreen03> {
  OTPTimer controllerOtpTimer = Get.put(OTPTimer());

  @override
  void initState() {
    // TODO: implement initState
    controllerOtpTimer.startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              keyboardType: TextInputType.number,
              controller: otp,
              decoration: const InputDecoration(
                constraints: BoxConstraints(maxWidth: 300),
                labelText: "Enter OTP here...",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                verifyOtp(widget.id, widget.resend);
              },
              child: const Text("Verify"),
            ),
            GetBuilder<OTPTimer>(
              builder: (controller) => Column(
                children: [
                  Text(controller.second.toString()),
                  controller.isResend
                      ? TextButton(
                          onPressed: () {
                            resendOtp();
                          },
                          child: const Text("Resend OTP"),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
