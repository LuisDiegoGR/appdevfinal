import 'dart:io';

import 'package:appdevfinal/Citas.dart';
import 'package:appdevfinal/InicioApp.dart';
import 'package:appdevfinal/Notification.dart';
import 'package:appdevfinal/Personalinfo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TerceraPag extends StatefulWidget {
  const TerceraPag ({Key? key}) : super(key: key);

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const InicioApp()),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF3A8D8A), Color(0xFF145647)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : (FirebaseAuth.instance.currentUser?.photoURL != null
                            ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                            : const AssetImage('assets/images/Placeholder.jpg') as ImageProvider),
                    backgroundColor: Colors.white,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.white),
                      onPressed: _getImage,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30), 
              RawMaterialButton(
                fillColor: const Color(0xFF1C5F5A),
                elevation: 5.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)
                ),
                onPressed: _uploadImage,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.cloud_upload, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Upload Image',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              RawMaterialButton(
                fillColor: const Color(0xFF1C5F5A),
                elevation: 5.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PersonalInfo()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.person, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Informacion Personal',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 15, 
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              RawMaterialButton(
                fillColor: const Color(0xFF1C5F5A),
                elevation: 5.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const NotificationPage()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.notifications, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Notificaciones',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              RawMaterialButton(
                fillColor: const Color(0xFF1C5F5A),
                elevation: 5.0,
                padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const Citas()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.calendar_today, color: Colors.white),
                    SizedBox(width: 10),
                    Text(
                      'Agendar Cita',
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
