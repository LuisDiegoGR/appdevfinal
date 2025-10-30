import 'package:flutter/material.dart';

class Overlapped extends StatelessWidget {
  const Overlapped({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación'),
      ),
      body: Center(
        child: const Text(
          'Aquí estará la pantalla de evaluación',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
