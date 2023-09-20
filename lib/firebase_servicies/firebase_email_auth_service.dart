import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constant/firebase const.dart';

class FirebaseEmailAuthService {
  static Future<UserCredential?> SignUpUser(
      {required emailid,
      required pasword,
      required BuildContext context}) async {
    try {
      UserCredential userCredential = await kFirebaseAuth
          .createUserWithEmailAndPassword(email: emailid, password: pasword);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('${e.message}')));
    }
  }

  static Future<UserCredential?> SigninUser({
    required emailid,
    required pasword,
  }) async {
    try {
      UserCredential userCredential = await kFirebaseAuth
          .signInWithEmailAndPassword(email: emailid, password: pasword);
      return userCredential;
    } on FirebaseAuthException catch (e) {
      print('Eroor==${e.message}');
    }
  }

  static Future SignOut() async {
    try {
      kFirebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      print("Error==${e.message}");
    }
  }
}
