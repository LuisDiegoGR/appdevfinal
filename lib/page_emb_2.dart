import 'package:appdevfinal/page_embarazo.dart';
import 'package:flutter/material.dart';

class PageEmb2 extends StatefulWidget {
  const PageEmb2({super.key});

  @override
  State<PageEmb2> createState() => _PageEmb2State();
}

class _PageEmb2State extends State<PageEmb2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => PageEmbarazo())
            );
          },
        ),
        title: Text('Prueba de scroll 2'),
        shadowColor: Colors.grey,
        scrolledUnderElevation: 10.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Riesgos preconcepcionales',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 16),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Antecedentes de embarazos previos:', 
                    style: TextStyle(
                      color: Colors.green, 
                      fontWeight: FontWeight.bold
                      ),
                    ),
                    TextSpan(text: ' Abortos previos, muertes fetales y neonatales, partos prematuros, bajo peso al nacer, enfermedades hipertensivas del embarazo, periodo intergenésico corto < de 2 años, diabetes gestacional',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      ), 
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}