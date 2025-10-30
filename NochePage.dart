import 'package:flutter/material.dart';

class NochePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página Noche'),
      ),
      body: Center(
        child: Text(
          'Contenido de la Noche',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
