import 'dart:io';

import 'package:appdevfinal/About.dart';
import 'package:appdevfinal/Notification.dart';
import 'package:appdevfinal/Personalinfo.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:appdevfinal/InicioApp.dart'; // Importa tus archivos según sea necesario

class TerceraPag extends StatefulWidget {
  const TerceraPag ({Key? key});

  @override
  State<TerceraPag> createState() => _TerceraPagState();
}

class _TerceraPagState extends State<TerceraPag> {
 final ImagePicker _picker = ImagePicker();
 File? _image;

Future<void> _getImage() async {
  final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
  setState(() {
    if (pickedFile != null) {
      _image = File(pickedFile.path);
    } else {
      print('No image selected.');
    }
  });
}

Future<void> _uploadImage() async {
  try {
    if (_image != null) {
      Reference ref = FirebaseStorage.instance.ref().child('SubirImage/${FirebaseAuth.instance.currentUser!.uid}.jpg');
      UploadTask uploadTask = ref.putFile(_image!);
      
      uploadTask.whenComplete(() async {
        try {
          String imageURL = await ref.getDownloadURL();
          User? user = FirebaseAuth.instance.currentUser;
          await user?.updatePhotoURL(imageURL);
          setState(() {
            // Actualiza el estado si es necesario
          });
          print('Image uploaded successfully.');
        } catch (e) {
          print('Error getting download URL: $e');
        }
      });
    } else {
      print('No image selected.');
    }
  } catch (e) {
    print('Error uploading image: $e');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const InicioApp()),
            );
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
              CircleAvatar(
              radius: 80,
              backgroundImage: _image != null
                  ? FileImage(_image!)
                  : (FirebaseAuth.instance.currentUser?.photoURL != null
                      ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                      : const AssetImage('assets/images/Placeholder.jpg') as ImageProvider),
            ),
            SizedBox(height: 20), // Espacio en blanco
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 130.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: _getImage,
              child: Text(
                'Select Image',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio en blanco
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 90.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: _uploadImage,
              child: Text(
                'Upload Image to Firebase',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                ),
                ),
            ),
            SizedBox(height: 20.0),
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 105.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => PersonalInfo()),
                );
              },
              child: Text(
                'Informacion Personal',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                ),
                ),
            ),
            SizedBox(height: 20.0),
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 130.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: Text(
                'Notificaciones',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                ),
                ),
            ),
            SizedBox(height: 20.0),
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 110.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => About()),
                );
              },
              child: Text(
                'Acerca de nosotros',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Roboto',
                  fontSize: 15,
                ),
                ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
