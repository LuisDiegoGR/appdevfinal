import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'TerceraPage.dart';
import 'informacion1.dart';
import 'package:appdevfinal/user_list.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> with TickerProviderStateMixin {
  File? _image;

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
                    : const AssetImage('assets/images/Placeholder.jpg')
                        as ImageProvider),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings, color: Colors.black),
            iconSize: 30.0,
            onPressed: () {
              if (mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const TerceraPag()),
                );
              }
            },
          )
        ],
        backgroundColor: Color(0xFFFFFFFF),
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFFFFF), // Blanco puro
              Color.fromARGB(255, 233, 233, 233), // Gris oscuro
            ], // Colores del degradado
          ),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 8,
                    color: Colors.white,
                    shadowColor: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/doctora.png',
                            width: 150,
                          ),
                          RawMaterialButton(
                            fillColor: Color.fromARGB(255, 46, 46, 46),
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 100),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserListScreen()));
                            },
                            child: const Text(
                              'Consultar Especialista',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Colors.white,
                    elevation: 8,
                    shadowColor: Colors.black.withOpacity(0.5),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/citas.png',
                            width: 150,
                          ),
                          RawMaterialButton(
                            fillColor: Color.fromARGB(255, 46, 46, 46),
                            elevation: 0.0,
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 100.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const Informacion1()));
                            },
                            child: const Text(
                              'Informacion Pediatrica',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 55),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
