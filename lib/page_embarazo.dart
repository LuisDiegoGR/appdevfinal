import 'package:appdevfinal/informacion1.dart';
import 'package:appdevfinal/page_emb_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PageEmbarazo extends StatefulWidget {
  @override
  _PageEmbarazoState createState() => _PageEmbarazoState();
}

class _PageEmbarazoState extends State<PageEmbarazo>
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Antes del Embarazo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Image.asset(
                'assets/images/pareja.png',
                width: 150,
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
                    'Es derecho de cada individuo el poder decidir acerca del número de hijos y el momento de su vida en que decida tenerlos. Se hace necesario informarse al respecto.',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Potenciales riesgos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                '• Biológicos\n• Sociodemográficos\n• Económicos',
                style: TextStyle(fontSize: 18),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'El embarazo es un hecho trascendental en el ámbito familiar y principalmente en la vida de la mujer, ya que representará una carga emocional y de cambios biológicos, los cuales, por sí solos, representarán un riesgo tanto para la madre como para el bebé.',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Es importante identificar los diferentes factores de riesgo antes (Preconcepcionales), durante (obstétricos) o después de la gestación (Perinatales) que aumentan la probabilidad de complicaciones que pongan en riesgo la vida de la madre tanto como para el hijo, así como en su posterior desarrollo psicomotor.',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'La acción que cobra relevancia es realizar la detección oportuna de estas condiciones que pueden poner en riesgo el embarazo.',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Causas de muerte materna',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints:
                    const BoxConstraints(maxHeight: 200, maxWidth: 200),
                child: PieChart(
                  PieChartData(sections: [
                    PieChartSectionData(
                      value: 20.4,
                      title: '20.4%',
                      color: Colors.blue,
                      radius: 50,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      value: 20.2,
                      title: '20.2%',
                      color: Colors.red,
                      radius: 50,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    PieChartSectionData(
                      value: 8.7,
                      title: '8.7%',
                      color: Colors.green,
                      radius: 50,
                      titleStyle: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 15),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.blue),
                    title: Text('Hemorragia obstétrica'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.red),
                    title: Text('Enfermedad hipertensiva'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.green),
                    title: Text('Aborto'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Causas de muerte perinatal con más de 500g y del recién nacido hasta los 7 días',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              const Text(
                '• Asfixia perinatal\n• Infecciones\n• Defectos congénitos\n• Prematuridad',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 30),
              RawMaterialButton(
                fillColor: const Color.fromARGB(255, 0, 0, 0),
                elevation: 0.0,
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 100),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => PageEmb2()));
                },
                child: const Text(
                  'Continuar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
