import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'TerceraPage.dart';
import 'consultar_especialista.dart';
import 'informacion1.dart';


class InicioApp extends StatefulWidget {
  const InicioApp({Key? key}) : super(key: key);

  @override
  _InicioAppState createState() => _InicioAppState();
}
class _InicioAppState extends State<InicioApp> {
  File? _image;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: CircleAvatar(
            radius: 10.0,
                backgroundImage: _image != null
      ? FileImage(_image!)
      : (FirebaseAuth.instance.currentUser?.photoURL != null
          ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
          : const AssetImage('assets/default_profile_image.jpg') as ImageProvider),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              iconSize: 40.0,
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TerceraPag()),
                );
              },
            )
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Primer contenedor con imagen delante
              Stack(
                children: [
                  Container(
                    width: 350,
                    height: 150, // Reducimos la altura a 150
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Consultar Especialista',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(left: 40),
                  ),
                  Positioned(
                    top: 100, // Ajusta la posición vertical del botón
                    left: 128, // Ajusta la posición horizontal del botón
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegar a la página ConsultarEspecialista
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => ConsultarEspecialista()),
                        );
                      },
                      child: Text(
                        'Ir',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/DocGirl.png',
                      width: 130,
                      height: 290,
                      alignment: Alignment.centerRight,
                    ),
                    padding: EdgeInsets.only(left: 26),
                  ),
                ],
              ),
              SizedBox(height: 30),
              // Segundo contenedor con imagen delante
              Stack(
                children: [
                  Container(
                    width: 350,
                    height: 150, // Reducimos la altura a 150
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Center(
                      child: Text(
                        'Informacion',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 100, // Ajusta la posición vertical del botón
                    left: 110, // Ajusta la posición horizontal del botón
                    child: ElevatedButton(
                      onPressed: () {
                        // Navegar a la página Informacion1
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => Informacion1()),
                        );
                      },
                      child: Text(
                        'Empezar',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                  Container(
                    child: Image.asset(
                      'assets/images/DocMan.png',
                      width: 130,
                      height: 290,
                      alignment: Alignment.centerRight,
                    ),
                    padding: EdgeInsets.only(left: 230),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
