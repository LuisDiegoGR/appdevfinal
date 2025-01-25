import 'package:appdevfinal/page_emb_3.dart';
import 'package:appdevfinal/page_embarazo.dart';
import 'package:flutter/material.dart';

class PageEmb2 extends StatefulWidget {
  const PageEmb2({super.key});

  @override
  State<PageEmb2> createState() => _PageEmb2State();
}

class _PageEmb2State extends State<PageEmb2>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PageEmbarazo()));
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Riesgos preconcepcionales',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                color: Colors.white,
                shadowColor: Colors.black.withOpacity(0.5),
                child: const Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Antecedentes de embarazos previos: Abortos previos, muertes fetales y neonatales, partos prematuros, bajo peso al nacer, enfermedades hipertensivas del embarazo, periodo intergenésico corto < de 2 años, diabetes gestacional',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Características propias de la madre',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
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
                        'Edad materna: Embarazo adolescente (10 a 19 años) y mujeres mayores de 35 años.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Antecedentes patológicos: Hipertensión pregestacional, Diabetes, anemia, tuberculosis, discapacidad intelectual, enfermedades psiquiátricas, estado nutricional, infecciones de transmisión sexual (VIH, Sifilis, gonorrea, hepatitis), consumo de tabaco, drogas.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 15),
                      Text(
                        'Durante este periodo que la mujer no está embarazada, se han de identificar los diferentes factores que pueden poner en riesgo su vida y la del producto durante el embarazo.',
                        style: TextStyle(
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'En este momento se tienen que realizar acciones preventivas como:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                '• Corregir hábitos alimenticios para llevar a un adecuado estado nutricional.\n'
                '• Control de enfermedades crónicas y adicciones. \n'
                '• Tamizaje para Infecciones de transmisión sexual.\n'
                '• Aplicar vacunas (Td, Sarampion-Rubeola). \n'
                '• Realizar citología vaginal.',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              const Text(
                'Riesgo obsterico',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                '• Embarazo múltiple.\n'
                '• Diabetes gestacional. \n'
                '• Preeclamsia/eclampsia.\n'
                '• Infecciones de vías urinarias / Cervicovaginitis. \n'
                '• Ruptura prematura de membranas .\n'
                '• Complicaciones obstétricas (Hemorragias, placenta previa, acretismo placentario, ruptura uterina).',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              RawMaterialButton(
                fillColor: const Color.fromARGB(255, 0, 0, 0),
                elevation: 0.0,
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const PageEmb3()));
                },
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
