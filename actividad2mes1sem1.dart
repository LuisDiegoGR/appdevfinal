import 'package:flutter/material.dart';

class Actividad2Mes1Sem1 extends StatelessWidget {
  const Actividad2Mes1Sem1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Actividad 2 Mes 1 - Semana 1',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
      ),
      body: const Center(
        child: Text(
          'Contenido de la actividad para el dia 2 para el Mes 1, Semana 1.',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}