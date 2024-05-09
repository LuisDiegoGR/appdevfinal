import 'dart:io';

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
        Reference ref = FirebaseStorage.instance.ref().child('uploads/${FirebaseAuth.instance.currentUser!.uid}.jpg');
        UploadTask uploadTask = ref.putFile(_image!);
        TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
        
      
        String imageURL = await taskSnapshot.ref.getDownloadURL();

        User? user = FirebaseAuth.instance.currentUser;
        // ignore: deprecated_member_use
        await user?.updateProfile(photoURL: imageURL);

    
        setState(() {
          
        });

        print('Image uploaded successfully.');
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
                      : const AssetImage('assets/default_profile_image.jpg') as ImageProvider),
            ),
            SizedBox(height: 20), // Espacio en blanco
            ElevatedButton(
              onPressed: _getImage,
              child: Text('Select Image'),
            ),
            SizedBox(height: 20), // Espacio en blanco
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image to Firebase'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Personalinfo()),
                );
              },
              child: Text('Informacion Personal'),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => NotificationPage()),
                );
              },
              child: Text('Notificaciones'),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
