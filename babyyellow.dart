import 'package:flutter/material.dart';
import 'mes4amarillo.dart';
import 'mes5amarillo.dart';
import 'mes6amarillo.dart';

class BabyYellowPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluación Amarillo'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildButton(context, 'Mes 4 Amarillo', Icons.looks_4, Mes4Amarillo()),
            SizedBox(height: 20),
            _buildButton(context, 'Mes 5 Amarillo', Icons.looks_5, Mes5Amarillo()),
            SizedBox(height: 20),
            _buildButton(context, 'Mes 6 Amarillo', Icons.looks_6, Mes6Amarillo()),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon, Widget page) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.yellow[700],
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      icon: Icon(icon, size: 30),
      label: Text(text),
    );
  }
}





































