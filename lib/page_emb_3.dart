import 'package:appdevfinal/page_emb_2.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class PageEmb3 extends StatefulWidget {
  const PageEmb3({super.key});

  @override
  State<PageEmb3> createState() => _PageEmb3State();
}

class _PageEmb3State extends State<PageEmb3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PageEmb2())
            );
          },
        ),
        title: const Text('Prueba de scroll 3'),
        shadowColor: Colors.grey,
        scrolledUnderElevation: 10.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Factores perinatales',
                style:  TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Roboto'),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 22),
              const Text(
                '• Estrato socioeconómico bajo (Signos neurológicos blandos desaparecen más tardíamente.\n'
                '• Bajo peso al nacer \n'
                '• Prematures \n'
                '• Hipoxia perinatal',
                style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.normal, fontFamily: 'Roboto'),
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Puede condicionar',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: ' la aparición de una encefalopatía dentro de las primeras 6-24 hrs, denominándosele así “Encefalopatía hipóxico-isquémica” y se divide en 3 grados',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ]
                ),
              ),
              const SizedBox(height: 24),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.green),
                    title: Text('Leve: Irritabilidad, hipertonía leve y succión débil.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.yellow),
                    title: Text('Moderada: Letargia e hipotonía y pueden aparecer convulsiones focales o generalizadas.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.red),
                    title: Text('Grave: Estado comatoso con hipotonía marcada y ausencia total del reflejo de succión.'),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'Hipoxia',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 22),
              SizedBox(
                height: 250,
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(
                        value: 85.0,
                        title: '85%',
                        color: Colors.blue,
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: 10.0,
                        title: '10%',
                        color: Colors.red,
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      PieChartSectionData(
                        value: 5.0,
                        title: '5%',
                        color: Colors.green,
                        radius: 50,
                        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.blue),
                    title: Text('Durante el parto'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.red),
                    title: Text('Periodo neonatal'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.green),
                    title: Text('inicio del trabajo de parto'),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              const Text(
                'Causas relacionadas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 22),
              const Text(
                '• interrupción de la circulación umbilical por compresión, prolapso o accidentes del cordón, circulares irreductibles. \n'
                '\n'
                '•  Desprendimiento prematuro de placenta, placenta previa, hipotensión materna y alteraciones de la contractibilidad uterina.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'El periodo perinatal',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: ' es la etapa más vulnerable del ser humano ya que se presentan adaptaciones de órganos y sistemas durante la transición de la vida intrauterina a la extrauterina. ',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ]
                ),
              ),
              const SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.justify,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'La capacidad del ',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                    TextSpan(text: 'recién nacido para comenzar su vida extrauterina desarrollando todo su potencial genético y posterior crecimiento físico e intelectual, depende principalmente de su posibilidad para superar diversas situaciones de peligro en la gestación y el parto. ',
                    style: TextStyle(
                      color: Colors.black,
                      ),
                    ),
                  ]
                ),
              ),
              const SizedBox(height: 22),
            ],
          ),
        ),
      ),
    );
  }
}