import 'package:appdevfinal/page_emb_3.dart';
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
                    TextSpan(text: 'Antecedentes de embarazos previos', 
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
              SizedBox(height: 16),
              Text(
                'Características propias de la madre',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: ' Edad materna: ',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: 'Embarazo adolescente (10 a 19 años) y mujeres mayores de 35 años',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Antecedentes patológicos: ',
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: 'Hipertensión pregestacional, Diabetes, anemia, tuberculosis, discapacidad intelectual, enfermedades psiquiátricas, estado nutricional, infecciones de transmisión sexual (VIH, Sifilis, gonorrea, hepatitis), consumo de tabaco, drogas',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 21),
              RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Durante ',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: 'este periodo que la mujer no está embarazada, se han de identificar los diferentes factore que pueden poner en riesgo su vida y la del producto durante el embarazo. ',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 22),
              Text(
                'En este momento se tienen que realizar acciones preventivas como:',
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22),
              Text(
                '• Corregir hábitos alimenticios para llevar a un adecuado estado nutricional.\n'
                '• Control de enfermedades crónicas y adicciones. \n'
                '• Tamizaje para Infecciones de transmisión sexual.\n'
                '• Aplicar vacunas (Td, Sarampion-Rubeola). \n'
                '• Realizar citología vaginal.',
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 22),
              Text(
                'Riesgo obsterico',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 22),
              Text(
                '• Embarazo múltiple.\n'
                '• Diabetes gestacional. \n'
                '• Preeclamsia/eclampsia.\n'
                '• Infecciones de vías urinarias / Cervicovaginitis. \n'
                '• Ruptura prematura de membranas .\n'
                '• Complicaciones obstétricas (Hemorragias, placenta previa, acretismo placentario, ruptura uterina).',
                style: TextStyle(fontSize: 17),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 35),
              RawMaterialButton(
              fillColor: Colors.green,
              elevation: 0.0,
              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PageEmb3()),
                  );
                },
                child: Text(
                  'Continuar',
                  style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
              ),
            ),
            SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}