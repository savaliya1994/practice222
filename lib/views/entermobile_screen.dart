import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/constant/firebase%20const.dart';
import 'package:firebase_demo/views/otp_screen.dart';
import 'package:flutter/material.dart';

String? varificationcode;

class EnterphonenoScreen extends StatefulWidget {
  const EnterphonenoScreen({Key? key}) : super(key: key);

  @override
  State<EnterphonenoScreen> createState() => _EnterphonenoScreenState();
}

class _EnterphonenoScreenState extends State<EnterphonenoScreen> {
  final mobileNo = TextEditingController();
  Future sendOTP() async {
    await kFirebaseAuth.verifyPhoneNumber(
      phoneNumber: '+91 ${mobileNo.text}',
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('${error.message}')));
      },
      codeSent: (verificationId, forceResendingToken) {
        varificationcode = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Enter your mobile no.',
            textScaleFactor: 1.5,
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: mobileNo,
              maxLength: 10,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  counterText: "",
                  hintText: 'Enter your mobile no.',
                  prefixIcon: Icon(Icons.call_rounded),
                  prefixIconColor: Colors.grey),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          MaterialButton(
            color: primaryclr,
            onPressed: () async {
              await sendOTP().then((value) => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPScreen(),
                  )));
            },
            child: Text(
              'Send OTP',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
