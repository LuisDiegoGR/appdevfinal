import 'package:appdevfinal/detalle_actividad_page.dart';
import 'package:appdevfinal/detalle_actividad_page2.dart';
import 'package:appdevfinal/detalle_actividad_page3.dart';
import 'package:appdevfinal/detalle_actividad_page4.dart';
import 'package:appdevfinal/page_alteraciones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EvaluaTemp extends StatefulWidget {
  const EvaluaTemp({Key? key}) : super(key: key);

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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PageAlteraciones()),
            );
          },
        ),
        title: const Text(
          'Evaluación del Desarrollo',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 130),
          Container(
            height: 200, // Altura de la imagen
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/Babywithmom.png'), // Ruta de tu imagen
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: ListView.builder(
                  padding: EdgeInsets.only(top: 16.0), // Ajuste de padding arriba
                  itemCount: actividades.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color.fromARGB(255, 168, 179, 252), Color(0xFF7986CB)], // Colores del gradiente
                            ),
                          ),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: const Icon(
                              Icons.child_care,
                              size: 40,
                              color: Colors.white, // Color del ícono
                            ),
                            title: Text(
                              actividades[index],
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white, // Color del texto
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white, // Color del ícono
                            ),
                            onTap: () {
                              Widget page;
                              switch (index) {
                                case 0:
                                  page = DetalleActividadPage(
                                      actividad: 'De 0 a 3 meses');
                                  break;
                                case 1:
                                  page = const DetalleActividadPage2(
                                      actividad: 'De 4 a 6 meses');
                                  break;
                                case 2:
                                  page = const DetalleActividadPage3(
                                      actividad: 'De 7 a 9 meses');
                                  break;
                                case 3:
                                  page = const DetalleActividadPage4(
                                      actividad: 'De 10 a 12 meses');
                                  break;
                                default:
                                  page = DetalleActividadPage(
                                      actividad: 'De 0 a 3 meses');
                                  break;
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => page,
                                ),
                              );
                            },
                          ),
                        )
                            .animate()
                            .fadeIn(
                                duration: const Duration(milliseconds: 500),
                                delay: Duration(milliseconds: index * 300))
                            .slide(
                                begin: const Offset(-1, 0),
                                duration: const Duration(milliseconds: 1000),
                                delay: Duration(milliseconds: index * 300)),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void main() => runApp(const MaterialApp(
      home: EvaluaTemp(),
    ));
