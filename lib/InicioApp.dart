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
  bool _firstImageVisible = false;
  bool _secondImageVisible = false;

  @override
  void initState() {
    super.initState();
    _animateImages();
  }

  void _animateImages() async {
    await Future.delayed(Duration(milliseconds: 500)); // Esperar un momento antes de animar la primera imagen
    setState(() {
      _firstImageVisible = true;
    });
    await Future.delayed(Duration(milliseconds: 500)); // Esperar un momento antes de animar la segunda imagen
    setState(() {
      _secondImageVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.account_circle),
            iconSize: 40.0,
            onPressed: () {
              // Acción al presionar el botón del perfil
            },
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
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              // Primer contenedor con imagen desde el lado derecho
              _buildAnimatedContainer(
                context,
                'assets/images/DocGirl.png',
                'Consultar Especialista',
                () {
                  // Navegar a la página ConsultarEspecialista
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ConsultarEspecialista()),
                  );
                },
                Alignment.centerRight,
              ),
              SizedBox(height: 30),
              // Segundo contenedor con imagen desde el lado izquierdo
              _buildAnimatedContainer(
                context,
                'assets/images/DocMan.png',
                'Informacion Pediatrica',
                () {
                  // Navegar a la página Informacion1
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Informacion1()),
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
      duration: Duration(seconds: 1),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(alignment.x * (1 - value) * MediaQuery.of(context).size.width, 0),
          child: child,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto',
              ),
            ),
            SizedBox(height: 20),
            AnimatedOpacity(
              opacity: _firstImageVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 500),
              child: SizedBox(
                height: 300,
                width: 300,
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: onPressed,
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
          ],
        ),
      ),
    );
  }
}