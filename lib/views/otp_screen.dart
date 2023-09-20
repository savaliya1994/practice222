import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/constant/firebase%20const.dart';
import 'package:firebase_demo/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import 'entermobile_screen.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? code;

  Future<UserCredential?> varifycode() async {
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: varificationcode!, smsCode: code!);

    try {
      UserCredential userCredential =
          await kFirebaseAuth.signInWithCredential(phoneAuthCredential);
      return userCredential;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Invalid OTP')));
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'we send you OTP in your mobile',
              textScaleFactor: 1.5,
            ),
            SizedBox(
              height: 30,
            ),
            Pinput(
              length: 6,
              keyboardType: TextInputType.number,
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              onCompleted: (value) {
                setState(() {
                  code = value;
                });
              },
              defaultPinTheme: PinTheme(
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)),
                height: 70,
                width: 70,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            MaterialButton(
              color: primaryclr,
              onPressed: () async {
                await varifycode().then((value) {
                  if (value!.user != null) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  } else {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text('Invalid OTP')));
                  }
                });
              },
              child: Text(
                'Next',
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      )),
    );
  }
}
