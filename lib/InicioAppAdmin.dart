import 'package:appdevfinal/pantalla_siguiente.dart';
import 'package:flutter/material.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //coment
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PantallaSiguiente())
            );
          },
        ),
      ),
    );
  }
}