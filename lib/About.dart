import 'package:appdevfinal/TerceraPage.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            //coment
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TerceraPag())
            );
          },
        ),
      ),
    );
  }
}