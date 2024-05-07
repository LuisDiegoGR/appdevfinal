import 'package:flutter/material.dart';

class PageAlteraciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bienvenidos a Alteraciones en el Desarrollo'),
      ),
      body: Center(
        child: Text(
          '¡Bienvenidos a la sección de Alteraciones en el Desarrollo!',
          style: TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
