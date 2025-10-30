import 'package:flutter/material.dart';

class CalendarioMes6Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario Mes 6'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Contenido del Calendario del Mes 6',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
