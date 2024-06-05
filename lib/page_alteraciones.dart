import 'package:appdevfinal/informacion1.dart';
import 'package:flutter/material.dart';

class PageAlteraciones extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => Informacion1()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'ALTERACIONES DE LA SUCCIÓN - DEGLUCIÓN',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.0),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Durante la alimentación,',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: ' la deglución es un proceso involuntario y reflejo que está presente desde el nacimiento. Para que esta se lleve a cabo de manera adecuada, es necesaria la integración de una gran variedad de estructuras que participan en el proceso:',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                '• Óseas.\n'
                '• Musculares.\n'
                '• Nerviosas.',
                style: TextStyle(
                  fontSize: 20,
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 20.0),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Que canalizan las sensaciones y',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: ' los movimientos con la deglución. Consta de tres fases, coordinadas entre ellas y con la respiración: fase oral, fase faríngea y fase esofágica.',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
