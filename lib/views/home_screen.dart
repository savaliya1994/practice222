import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/firebase_servicies/firebase_email_auth_service.dart';
import 'package:firebase_demo/firebase_servicies/google_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Sign_in_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'HomeScreen',
              textScaleFactor: 2,
            ),
            MaterialButton(
              onPressed: () async {
                try {
                  await FirebaseEmailAuthService.SignOut();
                } catch (e) {
               print('Error==$e');
                }

                try {
                  await GoogleAuthService.signOut();
                } catch (e) {
                  print('Error==$e');
                }

                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.remove('email').then((value) => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignInScreen(),
                    )));
              },
              color: Colors.orange,
              child: Text(
                'Sign out',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            )
          ],
        ),
      )),
    );
  }
}
