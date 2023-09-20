import 'package:flutter/material.dart';

import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageScreen extends StatefulWidget {
  @override
  _ImageScreenState createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Image Picker"),
        ),
        body: imageFile == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      color: Colors.grey,
                      onPressed: () {
                        _getFromGallery();
                      },
                      icon: Icon(Icons.photo),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    IconButton(
                      color: Colors.grey,
                      onPressed: () {
                        _getFromCamera();
                      },
                      icon: Icon(Icons.camera),
                    ),
                    IconButton(
                      color: Colors.grey,
                      onPressed: () {
                        vedioFromCamera();
                      },
                      icon: Icon(Icons.emergency_recording),
                    ),
                  ],
                ),
              )
            : Container(
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              ));
  }

  /// Get from gallery
  _getFromGallery() async {
    XFile? pickFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (pickFile != null) {
      setState(() {
        imageFile = File(pickFile.path);
      });
    }
  }

  /// Get from Camera
  _getFromCamera() async {
    PickedFile? pickFile = await ImagePicker()
        .getImage(source: ImageSource.camera, maxHeight: 300, maxWidth: 300);
    if (pickFile != null) {
      setState(() {
        imageFile = File(pickFile.path);
      });
    }
  }
}

vedioFromCamera() async {
  XFile? pickvedio = await ImagePicker()
      .pickVideo(source: ImageSource.camera, maxDuration: Duration(minutes: 5));
}
