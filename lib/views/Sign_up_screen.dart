import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/firebase_servicies/firebase_email_auth_service.dart';
import 'package:firebase_demo/firebase_servicies/google_auth_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailid = TextEditingController();
  final pasword = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? image;

  Future selectImage() async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        image = File(pickedImage.path);
      });
    }
  }

  Future<String?> uploadImagetoFirebase() async {
    try {
      await FirebaseStorage.instance.ref(emailid.text).putFile(image!);

      final imageUrl =
          await FirebaseStorage.instance.ref(emailid.text).getDownloadURL();
      return imageUrl;
    } catch (e) {
      print("ERROR==>${e}");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              selectImage();
            },
            child: Container(
              height: 170,
              width: 170,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Colors.grey.shade100),
              child: ClipOval(
                child: image == null
                    ? Icon(Icons.camera)
                    : Image.file(
                        image!,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: emailid,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              controller: pasword,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          MaterialButton(
            onPressed: () async {
              FirebaseEmailAuthService.SignUpUser(
                      emailid: emailid.text,
                      pasword: pasword.text,
                      context: context)
                  .then((value) async {
                if (value != null) {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.setString('email', emailid.text);

                  final imageUrl = await uploadImagetoFirebase();

                  FirebaseFirestore.instance
                      .collection('user')
                      .add({'email': emailid.text, ' userimageurl': imageUrl});

                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ));
                }
              });
            },
            color: Colors.orange,
            child: Text(
              'Sign Up',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              await GoogleAuthService.signInWithGoogle().then((value) async {
                SharedPreferences pref = await SharedPreferences.getInstance();
                pref.setString('email', emailid.text);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              });
            },
            child: Text("Contnue with google"),
          )
        ],
      )),
    );
  }
}
