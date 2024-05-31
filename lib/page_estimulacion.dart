import 'package:appdevfinal/EvaluacionTemp.dart';
import 'package:appdevfinal/informacion1.dart';
import 'package:flutter/material.dart';

class PageEstimulacion extends StatefulWidget {
  @override
  _PageEstimulacionState createState() => _PageEstimulacionState();
}

class _PageEstimulacionState extends State<PageEstimulacion> {

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
              'Tecnicas de valoracion inicial en el recien nacido',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              ),
              SizedBox(height: 5),
              Text(
                'APGAR',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 33, 9, 250)),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 23),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Esta escala se aplica',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: ' al recién nacido al minuto de haber nacido y a los 5 minutos, evaluando la frecuencia cardiaca, respiración, reflejos, tono muscular y color. De esta manera se cuantifican los signos de depresión neonatal. ',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Un puntaje',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: ' de 0 a 3 en a los 5 minutos se correlaciona con mortalidad neonatal en grandes poblaciones sin predecir disfunción neurológica.',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 23),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Un bajo puntaje',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: ' de APGAR a los minutos conlleva mayor riesgo de parálisis cerebral, Si el puntaje a los 5 minutos es de 7 o más, es poco probable que la hipoxia isquémica periparto causara encefalopatía neonatal',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, 
                  backgroundColor: Colors.blue, // Color del texto y del icono
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  textStyle: TextStyle(fontSize: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                  ),
                ), // Texto del botón
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => EvaluaTemp()),
                  );
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Evaluación'), // Texto del botón
                    SizedBox(width: 15), // Espacio entre el texto y el icono
                    Icon(Icons.arrow_forward_ios), // Icono de flecha hacia la derecha
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