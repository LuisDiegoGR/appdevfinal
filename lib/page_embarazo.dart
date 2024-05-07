import 'package:flutter/material.dart';

class PageEmbarazo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos a Embarazo de Alto Riesgo'),
      ),
      body: Center(
        child: Text(
          '¡Bienvenidos a la sección de Embarazo de Alto Riesgo!',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
