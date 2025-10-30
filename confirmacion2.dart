import 'package:flutter/material.dart';
import 'package:appdevfinal/actividades2.dart'; // Asegúrate de importar la página actividades2.dart

class Confirmacion2Page extends StatelessWidget {
  const Confirmacion2Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Confirmación', style: TextStyle(fontFamily: 'Fantasy')),
        backgroundColor: const Color(0xFF8E44AD),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '¿Tu bebé fue?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const SizedBox(height: 20),
            const Text(
              'Confirmación exitosa!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Has completado el proceso correctamente.',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  onPressed: () {
                    // Navegar a actividades2.dart cuando se presiona "Verde"
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Actividades2Page()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green, // Color verde para el botón
                  ),
                  child: const Text(
                    'Verde',
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),
                const SizedBox(width: 20), // Espacio entre los botones
                ElevatedButton(
                  onPressed: () {
                    // Navegar a actividades2.dart cuando se presiona "Amarillo"
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Actividades2Page()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow, // Color amarillo para el botón
                  ),
                  child: const Text(
                    'Amarillo',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


