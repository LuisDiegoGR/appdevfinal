import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'TerceraPage.dart';
import 'consultar_especialista.dart';
import 'informacion1.dart';
import 'chatbot.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({super.key});

  @override
  _InicioAppState createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> with TickerProviderStateMixin {
  File? _imagen;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
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
            backgroundImage: _imagen != null
                ? FileImage(_imagen!)
                : (FirebaseAuth.instance.currentUser?.photoURL != null
                    ? NetworkImage(FirebaseAuth.instance.currentUser!.photoURL!)
                    : const AssetImage('assets/images/Placeholder.jpg') as ImageProvider),
          ),
        ),
        title: const Text(
          'Bienvenido',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.cog, color: Colors.black87),
            onPressed: () {
              if (mounted) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const PerfilPage()),
                );
              }
            },
          ),
        ],
        backgroundColor: const Color(0xFFFFF7F8),
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFF0F5),
              Color(0xFFE0FFFF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
  children: [
    _buildAnimatedContainer(
      context,
      'assets/gifs/Estrellita.gif',
      'Tu bebé, su estrella',
      FontAwesomeIcons.star,
      () {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => ConsultarEspecialista()),
          );
        }
      },
      containerColor: const Color(0xFFFFE4E1),
      textColor: Colors.black87,
    ),
    const SizedBox(height: 37), // 👈 más espacio entre los botones
    _buildAnimatedContainer(
      context,
      'assets/gifs/Baby_doc.gif',
      'Información Pediátrica',
      FontAwesomeIcons.bookOpen,
      () {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Informacion1()),
          );
        }
      },
      containerColor: const Color(0xFFBFEFFF),
      textColor: Colors.black87,
    ),
    const SizedBox(height: 37), // 👈 más espacio entre los botones
    _buildAnimatedContainer(
      context,
      'assets/gifs/NEOBOT_3D.gif',
      'Consultar a Neobot',
      FontAwesomeIcons.commentDots,
      () {
        if (mounted) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => GeminiChatBot()),
          );
        }
      },
      imageWidth: 100,
      containerColor: const Color(0xFFFFFACD),
      textColor: Colors.black87,
    ),
  ],
),

          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedContainer(
    BuildContext context,
    String imagePath,
    String text,
    IconData icon,
    Function() onPressed, {
    double imageWidth = 90.0,
    Color containerColor = Colors.white,
    Color textColor = Colors.black,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
        height: 140, // Aumenta el tamaño para que no se vea amontonado
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: containerColor,
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 3,
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                padding: const EdgeInsets.only(left: 140, right: 20),
                child: Row(
                  children: [
                    Icon(icon, size: 32, color: textColor),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        text,
                        style: TextStyle(
                          color: textColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          shadows: const [
                            Shadow(
                              blurRadius: 3,
                              color: Colors.black12,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 15,
              top: -10,
              bottom: -10,
              child: Container(
                width: imageWidth,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(2, 5),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: InicioApp(),
    ));
