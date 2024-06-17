import 'package:appdevfinal/detalle_actividad_page.dart';
import 'package:appdevfinal/detalle_actividad_page2.dart';
import 'package:appdevfinal/detalle_actividad_page3.dart';
import 'package:appdevfinal/detalle_actividad_page4.dart';
import 'package:appdevfinal/page_alteraciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EvaluaTemp extends StatefulWidget {
  const EvaluaTemp({super.key});

  @override
  State<EvaluaTemp> createState() => _EvaluaTempState();
}

class _EvaluaTempState extends State<EvaluaTemp> {
  final List<String> actividades = [
    'De 0 a 3 meses',
    'De 4 a 6 meses',
    'De 7 a 9 meses',
    'De 10 a 12 meses'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PageAlteraciones()),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: actividades.length,
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 4,
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                contentPadding: const EdgeInsets.all(16.0),
                leading: const Icon(
                  Icons.bedroom_baby,
                  size: 40,
                  color: Colors.green,
                ),
                title: Text(
                  actividades[index],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Widget page;
                  switch (index) {
                    case 0:
                      page = DetalleActividadPage(actividad: 'De 0 a 3 meses');
                      break;
                    case 1:
                      page = const DetalleActividadPage2(actividad: 'De 4 a 6 meses');
                      break;
                    case 2:
                      page = const DetalleActividadPage3(actividad: 'De 7 a 9 meses');
                      break;
                    case 3:
                      page = const DetalleActividadPage4(actividad: 'De 10 a 12 meses');
                      break;
                    default:
                      page = DetalleActividadPage(actividad: 'De 0 a 3 meses');
                      break;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => page,
                    ),
                  );
                },
              )
              .animate()
              .fadeIn(duration: const Duration(milliseconds: 500)) 
              .slide(begin: Offset(index % 2 == 0 ? -1 : 1, 0), duration: const Duration(milliseconds: 1000)), 
            ).animate().fadeIn();
          },
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
  home: EvaluaTemp(),
));