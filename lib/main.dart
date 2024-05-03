import 'package:appdevfinal/pantalla_siguiente.dart'; // Importa el archivo Dart al que quieres redirigir
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'HRAEI',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'Rehabilitacion Pediatrica',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(
              'assets/images/tre.png', // Ruta de la imagen en tu proyecto
              width: 200,
            ),
            //Navigator.pushNamed(context, '/siguiente');
            const SizedBox(height: 40),
            RawMaterialButton(
              fillColor: Color(0xFF145647),
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 150.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              onPressed: () {
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => PantallaSiguiente()),
                );
              },
              child: const Text(
                'Comenzar',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
