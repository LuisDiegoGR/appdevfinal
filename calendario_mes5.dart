import 'package:flutter/material.dart';

class CalendarioMes5Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario Mes 5'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: Text(
          'Contenido del Calendario del Mes 5',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
