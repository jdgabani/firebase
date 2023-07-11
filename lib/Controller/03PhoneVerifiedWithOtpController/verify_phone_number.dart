import 'dart:async';
import 'dart:developer';
import 'package:firebase/Controller/03PhoneVerifiedWithOtpController/variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../view/03PhoneVerifiedWithOtpScreen/02_resend_otp.dart';

///Send OTP Button
void sendOtp() async {
  FirebaseAuth auth = FirebaseAuth.instance;

  await auth.verifyPhoneNumber(
    phoneNumber: clientPhoneNumber,
    verificationCompleted: (phoneAuthCredential) {
      log('verified');
    },
    verificationFailed: (error) {
      log('ERROR');
    },
    codeSent: (verificationId, forceResendingToken) {
      Get.to(
        () => ResendOtpScreen03(id: verificationId),
      );
    },
    codeAutoRetrievalTimeout: (verificationId) {
      log('TIME OUT');
    },
  );
}

///Verify OTP Button
void verifyOtp(dynamic id, dynamic resend) async {
  FirebaseAuth auth = FirebaseAuth.instance;

  PhoneAuthCredential credential = PhoneAuthProvider.credential(
    verificationId: id,
    smsCode: otp.text,
  );
  UserCredential userCredential = await auth.signInWithCredential(credential);

  log('${userCredential.user!.phoneNumber}');
  log(userCredential.user!.uid);
}

///OTP timer
class OTPTimer extends GetxController {
  bool isResend = false;
  int second = 10;

  void startTimer() {
    Timer timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      update();
      second--;
      if (second == 0) {
        timer.cancel();
        update();
        second = 10;
        isResend = true;
      }
    });
  }
}

///ReSend OTP Button
void resendOtp() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  await auth.verifyPhoneNumber(
    phoneNumber: clientPhoneNumber,
    verificationCompleted: (phoneAuthCredential) {
      log('verified');
    },
    verificationFailed: (error) {
      log('ERROR');
    },
    codeSent: (verificationId, forceResendingToken) {
      Get.to(
        ResendOtpScreen03(resend: forceResendingToken),
      );
    },
    codeAutoRetrievalTimeout: (verificationId) {
      log('TIME OUT');
    },
  );
}
