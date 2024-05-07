import 'package:flutter/material.dart';

class PageEstimulacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos'),
      ),
      body: Center(
        child: Text(
          '¡Bienvenidos a la sección de Estimulación Temprana!',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
