import 'package:appdevfinal/informacion1.dart';
import 'package:appdevfinal/page_emb_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PageEmbarazo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Informacion1()),
            );
          },
        ),
        title: Text('Prueba de scroll'),
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
                'Antes del Embarazo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              SizedBox(height: 16),
              Text(
                'Es derecho de cada individuo el poder decidir acerca del número de hijos y el momento de su vida en que decida tenerlos. Se hace necesario informarse al respecto.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 20),
              Text(
                'Potenciales riesgos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '• Biologicos\n'
                '• Sociodemográficos\n'
                '• Economicos',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              Text(
                'El embarazo es un hecho trascendental en el ámbito familiar y principalmente en la vida de la mujer, ya que representaran una carga emocional y de cambios biológicos, los cuales por si solos representaran un riesgo tanto para la madre como para el bebé.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 16),
              Text(
                'Es importante identificar los diferentes factores de riesgo antes (Preconcepcionales), durante (obstétricos) o después de la gestación (Perinatales) que aumentan la probabilidad de complicaciones pongan en riesgo la vida de la madre tanto como para el hijo, así como en su posterior desarrollo psicomotor',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 35),
              Text(
                'La acción que cobra relevancia es realizar la detección oportuna de estas condiciones que pueden poner en riesgo el embarazo. ',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: 11),
              Text(
                'Causas de muerte materna',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 15),
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 20.4,
                        title: '20.4%',
                        color: Colors.blue,
                        radius: 50,
                        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: 20.2,
                        title: '20.2%',
                        color: Colors.red,
                        radius: 50,
                        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: 8.7,
                        title: '8.7%',
                        color: Colors.green,
                        radius: 50,
                        titleStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.blue),
                    title: Text('Hemorragia obsterica'),
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
              SizedBox(height: 20),
              Text(
                'Causas de muerte perinatal con mas de 500mg y del recien nacido hasta los 7 dias',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              Text(
                '• Asfixia perinatal\n'
                '• Infecciones\n'
                '• Defectos congenitos\n'
                '• Prematuridad',
                style: TextStyle(fontSize: 18),
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
                    MaterialPageRoute(builder: (context) => PageEmb2()),
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

void main() => runApp(MaterialApp(
  home: PageEmbarazo(),
));
