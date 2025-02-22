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
  const TerceraPag({Key? key}) : super(key: key);

  @override
  State<TerceraPag> createState() => _TerceraPagState();
}

class _TerceraPagState extends State<TerceraPag>
    with SingleTickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('SubirImage/${FirebaseAuth.instance.currentUser!.uid}.jpg');
        UploadTask uploadTask = ref.putFile(_image!);

        uploadTask.whenComplete(() async {
          try {
            String imageURL = await ref.getDownloadURL();
            User? user = FirebaseAuth.instance.currentUser;
            await user?.updatePhotoURL(imageURL);
            setState(() {});
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
    final buttonStyle = ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.black,
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20.0),
      minimumSize: const Size(250, 60),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      elevation: 5.0,
      shadowColor: Colors.black.withOpacity(0.3),
    );

    return WillPopScope(
      onWillPop: () async {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const InicioApp()),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const InicioApp()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFFFFFFF), // Blanco puro
                Color.fromARGB(255, 171, 255, 209),
              ],
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
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
                              : (FirebaseAuth.instance.currentUser?.photoURL !=
                                      null
                                  ? NetworkImage(FirebaseAuth
                                      .instance.currentUser!.photoURL!)
                                  : const AssetImage(
                                          'assets/images/Placeholder.jpg')
                                      as ImageProvider),
                          backgroundColor: Colors.white,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              icon: const Icon(Icons.camera_alt,
                                  color: Colors.white),
                              onPressed: _getImage,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.cloud_upload),
                      label: const Text(
                        'Upload Image',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: buttonStyle,
                      onPressed: _uploadImage,
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.person),
                      label: const Text(
                        'Informacion Personal',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: buttonStyle,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => PersonalInfo()),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.notifications),
                      label: const Text(
                        'Notificaciones',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: buttonStyle,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const NotificationPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 20.0),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.calendar_today),
                      label: const Text(
                        'Agendar Cita',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: buttonStyle,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (context) => const Citas()),
                        );
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
