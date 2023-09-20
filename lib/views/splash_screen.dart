import 'dart:async';

import 'package:firebase_demo/views/Sign_in_screen.dart';
import 'package:firebase_demo/views/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String? userEmail;
  Future keeplogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    final Email = pref.getString('email');
    userEmail = Email;
    setState(() {});
  }

  void initState() {
    Timer(Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  userEmail != null ? HomeScreen() : SignInScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
          child: Icon(
        Icons.add_alert_rounded,
        color: Colors.white,
      )),
    );
  }
}
