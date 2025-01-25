import 'package:appdevfinal/page_emb_2.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class PageEmb3 extends StatefulWidget {
  const PageEmb3({super.key});

  @override
  State<PageEmb3> createState() => _PageEmb3State();
}

class _PageEmb3State extends State<PageEmb3>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const PageEmb2()));
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
                'Factores perinatales',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                '• Estrato socioeconómico bajo (Signos neurológicos blandos desaparecen más tardíamente.\n'
                '• Bajo peso al nacer \n'
                '• Prematures \n'
                '• Hipoxia perinatal',
                style: TextStyle(fontSize: 14),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
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
                        'Puede condicionar la aparición de una encefalopatía dentro de las primeras 6-24 hrs, denominándosele así “Encefalopatía hipóxico-isquémica” y se divide en 3 grados',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 25),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.green),
                    title: Text(
                        'Leve: Irritabilidad, hipertonía leve y succión débil.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.yellow),
                    title: Text(
                        'Moderada: Letargia e hipotonía y pueden aparecer convulsiones focales o generalizadas.'),
                  ),
                  ListTile(
                    leading: Icon(Icons.circle, color: Colors.red),
                    title: Text(
                        'Grave: Estado comatoso con hipotonía marcada y ausencia total del reflejo de succión.'),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Hipoxia',
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
                      value: 85.0,
                      title: '85%',
                      color: Colors.blue,
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: 10.0,
                      title: '10%',
                      color: Colors.red,
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    PieChartSectionData(
                      value: 5.0,
                      title: '5%',
                      color: Colors.green,
                      radius: 50,
                      titleStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ]),
                ),
              ),
              const SizedBox(height: 20),
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
                    title: Text('Inicio del trabajo de parto'),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              const Text(
                'Causas relacionadas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              const Text(
                '• Interrupción de la circulación umbilical por compresión, prolapso o accidentes del cordón, circulares irreductibles. \n'
                '\n'
                '• Desprendimiento prematuro de placenta, placenta previa, hipotensión materna y alteraciones de la contractibilidad uterina.',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
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
                        'El periodo perinatal es la etapa más vulnerable del ser humano ya que se presentan adaptaciones de órganos y sistemas durante la transición de la vida intrauterina a la extrauterina.',
                        style: TextStyle(fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
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
                        'La capacidad del recién nacido para comenzar su vida extrauterina desarrollando todo su potencial genético y posterior crecimiento físico e intelectual, depende principalmente de su posibilidad para superar diversas situaciones de peligro en la gestación y el parto.',
                        style: TextStyle(fontSize: 14),
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
    );
  }
}
