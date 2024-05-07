import 'package:flutter/material.dart';

class PageForo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos al Foro de Discusión'),
      ),
      body: Center(
        child: Text(
          '¡Bienvenidos al Foro de Discusión!',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
