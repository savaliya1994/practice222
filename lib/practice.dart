import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imagepicker extends StatefulWidget {
  const Imagepicker({Key? key}) : super(key: key);

  @override
  State<Imagepicker> createState() => _ImagepickerState();
}

class _ImagepickerState extends State<Imagepicker> {
  File? imageFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: imageFile == null
            ? Center(
                child: InkWell(
                child: Icon(
                  Icons.camera_alt,
                  size: 30,
                ),
                onTap: () {
                  getImageFromCamera();
                },
              ))
            : Container(
                child: Image.file(
                  imageFile!,
                  fit: BoxFit.cover,
                ),
              ));
  }

  getImageFromCamera() async {
    XFile? pickimage = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 1800, maxHeight: 1800);
    if (pickimage != null) {
      setState(() {
        imageFile = File(pickimage.path);
      });
    }
  }
}
