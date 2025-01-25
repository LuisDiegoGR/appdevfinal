import 'package:appdevfinal/informacion1.dart';
import 'package:flutter/material.dart';

class PageEstimulacion extends StatefulWidget {
  const PageEstimulacion({super.key});

  @override
  _PageEstimulacionState createState() => _PageEstimulacionState();
}

class _PageEstimulacionState extends State<PageEstimulacion>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Informacion1()));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 8,
                  color: Colors.white,
                  shadowColor: Colors.black.withOpacity(0.5),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Tecnicas de valoracion inicial en el recien nacido',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Esta escala se aplica al recién nacido al minuto de haber nacido y a los 5 minutos, evaluando la frecuencia cardiaca, respiración, reflejos, tono muscular y color. De esta manera se cuantifican los signos de depresión neonatal.',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Un puntaje  de 0 a 3 en a los 5 minutos se correlaciona con mortalidad neonatal en grandes poblaciones sin predecir disfunción neurológica.',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Un bajo puntaje de APGAR a los minutos conlleva mayor riesgo de parálisis cerebral, Si el puntaje a los 5 minutos es de 7 o más, es poco probable que la hipoxia isquémica periparto causara encefalopatía neonatal.',
                          style: TextStyle(
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
