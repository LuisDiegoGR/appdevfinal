import 'package:flutter/material.dart';

class ConsultarEspecialista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consultar Especialista'),
      ),
      body: Center(
        child: Text(
          '¡Bienvenidos!',
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
