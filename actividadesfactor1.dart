import 'package:flutter/material.dart';

class ActividadesFactor1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Actividades Factor 1'),
      ),
      body: Center(
        child: Text('Hola, este es un archivo de prueba'),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ActividadesFactor1(),
  ));
}
