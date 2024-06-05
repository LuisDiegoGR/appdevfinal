import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'TerceraPage.dart';
import 'consultar_especialista.dart';
import 'informacion1.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
  File? _image;
  bool _firstImageVisible = false;

  @override
  void initState() {
    super.initState();
    _animateImages();
  }

  void _animateImages() async {
    await Future.delayed(const Duration(milliseconds: 500)); 
    setState(() {
      _firstImageVisible = true;
    });
    await Future.delayed(const Duration(milliseconds: 500)); 
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 22.0,
            backgroundImage: _image != null
                ? FileImage(_image!)
                : (FirebaseAuth.instance.currentUser?.photoURL != null
                    ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                    : const AssetImage('assets/images/Placeholder.jpg') as ImageProvider),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            iconSize: 30.0,
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const TerceraPag()),
              );
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 30),
              _buildAnimatedContainer(
                context,
                'assets/images/DocGirl.png',
                'CONSULTAR ESPECIALISTA',
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ConsultarEspecialista()),
                  );
                },
                Alignment.centerRight,
              ),
              const SizedBox(height: 30),
              _buildAnimatedContainer(
                context,
                'assets/images/DocMan.png',
                'INFORMACION PEDIATRICA',
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Informacion1()),
                  );
                },
                Alignment.centerLeft,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer(BuildContext context, String imagePath, String text, Function() onPressed, Alignment alignment) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(alignment.x * (1 - value) * MediaQuery.of(context).size.width, 0),
          child: child,
        );
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AnimatedOpacity(
                opacity: _firstImageVisible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: onPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(20, 86, 71, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                ),
                child: const Text(
                  'IR',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
