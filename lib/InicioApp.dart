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

class _InicioAppState extends State<InicioApp> with TickerProviderStateMixin {
  File? _image;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation1;
  late Animation<Offset> _offsetAnimation2;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _offsetAnimation1 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimation2 = Tween<Offset>(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            icon: const Icon(Icons.settings, color: Colors.black),
            iconSize: 30.0,
            onPressed: () {
              if (mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const TerceraPag()),
                );
              }
            },
          )
        ],
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 15.0, // Adjust this value to increase/decrease the shadow
        shadowColor: Colors.black.withOpacity(0.9), // Adjust shadow color
      ),
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 10),
                  SlideTransition(
                    position: _offsetAnimation1,
                    child: _buildCustomContainer(
                      context,
                      'assets/images/DocGirl.png',
                      'Consultar Especialisa',
                      Alignment.centerLeft,
                      -30,
                      Alignment.centerLeft, // Alineación del texto
                      Alignment.centerLeft, // Alineación del botón
                      150,
                      -50.0, // Margen superior ajustable
                      110.0, // Desplazamiento horizontal del texto
                      -100.0, // Desplazamiento vertical de la imagen
                      -20.0, // Desplazamiento vertical del botón
                      () {
                        if (mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const ConsultarEspecialista()),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  SlideTransition(
                    position: _offsetAnimation2,
                    child: _buildCustomContainer(
                      context,
                      'assets/images/DocMan.png',
                      'Informacion Pediatrica',
                      Alignment.centerRight,
                      -70.0,
                      Alignment.centerRight, // Alineación del texto
                      Alignment.centerRight, // Alineación del botón
                      -170,
                      20.0, // Margen superior ajustable
                      -120.0, // Desplazamiento horizontal del texto
                      0.0, // Desplazamiento vertical de la imagen
                      -20.0, // Desplazamiento vertical del botón
                      () {
                        if (mounted) {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const Informacion1()),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Botón Consultar Especialista
          Positioned(
            top: MediaQuery.of(context).size.height / 3 - 30, // Ajusta la posición del botón
            left: MediaQuery.of(context).size.width / 2 - 20, // Ajusta la posición del botón
            child: ElevatedButton(
              onPressed: () {
                if (mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ConsultarEspecialista()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text(
                'Ir',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          // Botón Información Pediátrica
          Positioned(
            top: MediaQuery.of(context).size.height / 2, // Ajusta la posición del botón
            left: MediaQuery.of(context).size.width / 2 - 80, // Ajusta la posición del botón
            child: ElevatedButton(
              onPressed: () {
                if (mounted) {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Informacion1()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              ),
              child: const Text(
                'Ir',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomContainer(
    BuildContext context,
    String imagePath,
    String text,
    Alignment alignment,
    double imageOffset,
    Alignment textAlignment,
    Alignment buttonAlignment,
    double buttonOffset,
    double topPadding, // Parámetro para ajustar el margen superior
    double textHorizontalOffset, // Desplazamiento horizontal del texto
    double imageVerticalOffset, // Desplazamiento vertical de la imagen
    double buttonVerticalOffset, // Desplazamiento vertical del botón
    Function() onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        clipBehavior: Clip.none, // Permitir desbordamiento
        children: [
          // Contenedor negro
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 19),
            margin: EdgeInsets.only(top: 100 + topPadding), // Margen superior ajustable
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60), // Espacio para la imagen
                Align(
                  alignment: textAlignment,
                  child: Transform.translate(
                    offset: Offset(textHorizontalOffset, -20), // Desplazamiento horizontal del texto
                    child: Text(
                      text,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          // Imagen
          Positioned(
            top: -10 + imageVerticalOffset, // Ajustamos la posición de la imagen
            left: alignment == Alignment.centerLeft ? -80 + imageOffset : null,
            right: alignment == Alignment.centerRight ? -100 + imageOffset : null,
            child: _buildImage(imagePath),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(String imagePath) {
    return Container(
      width: 420, // Ajusta el ancho de la imagen según sea necesario
      height: 420, // Ajusta la altura de la imagen según sea necesario
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
