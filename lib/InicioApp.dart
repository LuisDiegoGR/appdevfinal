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
  late Animation<Offset> _offsetAnimationButton1;
  late Animation<Offset> _offsetAnimationButton2;

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

    _offsetAnimationButton1 = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));

    _offsetAnimationButton2 = Tween<Offset>(
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
        elevation: 15.0,
        shadowColor: Colors.black.withOpacity(0.9),
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
                      Alignment.centerLeft,
                      Alignment.centerLeft,
                      150,
                      -50.0,
                      110.0,
                      -100.0,
                      -20.0,
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
                      Alignment.centerRight,
                      Alignment.centerRight,
                      -170,
                      100.0,
                      -120.0,
                      0.0,
                      -20.0,
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
          Positioned(
            top: MediaQuery.of(context).size.height / 3 - 60,
            left: MediaQuery.of(context).size.width / 2 - 20,
            child: SlideTransition(
              position: _offsetAnimationButton1,
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
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 -(-125),
            left: MediaQuery.of(context).size.width / 3-30,
            child: SlideTransition(
              position: _offsetAnimationButton2,
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
    double topPadding,
    double textHorizontalOffset,
    double imageVerticalOffset,
    double buttonVerticalOffset,
    Function() onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            margin: EdgeInsets.only(top: 50 + topPadding),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Align(
                  alignment: textAlignment,
                  child: Transform.translate(
                    offset: Offset(textHorizontalOffset, -50),
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
          Positioned(
            top: -10 + imageVerticalOffset,
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
      width: 420,
      height: 420,
      padding: const EdgeInsets.all(8.0),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
