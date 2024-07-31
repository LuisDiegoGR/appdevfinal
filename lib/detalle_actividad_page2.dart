import 'package:appdevfinal/Citas.dart';
import 'package:appdevfinal/consultar_especialista.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:quickalert/quickalert.dart';

class DetalleActividadPage2 extends StatefulWidget {
  const DetalleActividadPage2({super.key, required this.actividad});
  final String actividad;

  @override
  State<DetalleActividadPage2> createState() => _DetalleActividadPage2State();
}

class _DetalleActividadPage2State extends State<DetalleActividadPage2> {
  int lenguajePuntaje = 0;
  int socialPuntaje = 0;
  int coordinacionPuntaje = 0;
  int motoraPuntaje = 0;

  int calcularPuntajeTotal() {
    return lenguajePuntaje +
        socialPuntaje +
        coordinacionPuntaje +
        motoraPuntaje;
  }

  void mostrarResultado() {
    int puntajeTotal = calcularPuntajeTotal();
    if (puntajeTotal >= 12) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Evaluación Completada',
        text: 'El desarrollo del bebé está bien.',
        confirmBtnText: 'OK',
      );
    } else if (puntajeTotal <= 4) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Atención al desarrollo',
        text:
            'El desarrollo se está viendo afectado, consulta un especialista.',
        confirmBtnText: 'Consulta',
        onConfirmBtnTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Citas()),
        ),
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Alerta de Desarrollo',
        text:
            'Hay áreas de desarrollo que necesitan atención. Por favor, agenda una cita.',
        confirmBtnText: 'Consultar especialista',
        onConfirmBtnTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (conext) => const ConsultarEspecialista()),
        ),
      );
    }
  }

  Widget _buildSlidableCategory(String title, String description, int value,
      ValueChanged<int> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        Text(
          description,
          style: const TextStyle(color: Colors.black87, fontSize: 16),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onHorizontalDragUpdate: (details) {
            setState(() {
              double newValue = (details.localPosition.dx /
                      MediaQuery.of(context).size.width *
                      4)
                  .clamp(0, 3);
              onChanged(newValue.toInt());
            });
          },
          child: Container(
            height: 60,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 114, 161, 241).withOpacity(0.3),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  left: (value / 3) * (MediaQuery.of(context).size.width - 93),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        value.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ).animate().move(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut),
        const SizedBox(height: 24),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 231, 231, 231),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      SizedBox(height: 30),
                      Text(
                        widget.actividad,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Ponderacion',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center
                          ),
                          ListTile(
                            leading: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.2),
                                shape: BoxShape.circle, 
                                
                              ),
                              child: const Icon(Icons.check,
                                  color: Colors.green,
                                  size: 28,
                                ),                     
                             ),
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                style: TextStyle(fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '3 ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 65, 65),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Lo hace',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.yellow.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lightbulb,
                                color: Colors.yellow,
                                size: 28,
                              ),
                            ),
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                style: TextStyle(fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '2 ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 65, 65),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Casualmente',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.lightbulb,
                                color: Colors.orange,
                                size: 28,
                              ),
                            ),
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                style: TextStyle(fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '1 ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 65, 65),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' A veces',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Container(
                              width: 35,
                              height: 35,
                              decoration: BoxDecoration(
                                color: Colors.red.withOpacity(0.2),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                                size: 28,
                              ),
                            ),
                            title: RichText(
                              textAlign: TextAlign.left,
                              text: const TextSpan(
                                style: TextStyle(fontSize: 20),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '0 ',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 65, 65, 65),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' Nunca',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildSlidableCategory(
                    'Lenguaje:',
                    'Balbucea. “Da-da”, “ma-ma”',
                    lenguajePuntaje,
                    (value) {
                      setState(() {
                        lenguajePuntaje = value;
                      });
                    },
                  ),
                  _buildSlidableCategory(
                    'Social:',
                    'Atiende con interés al sonido, busca con interés el sonido, sonríe espontáneamente',
                    socialPuntaje,
                    (value) {
                      setState(() {
                        socialPuntaje = value;
                      });
                    },
                  ),
                  _buildSlidableCategory(
                    'Coordinación:',
                    'Intenta la prensión de objetos, prensión global a mano plena (Barrido)',
                    coordinacionPuntaje,
                    (value) {
                      setState(() {
                        coordinacionPuntaje = value;
                      });
                    },
                  ),
                  _buildSlidableCategory(
                    'Motora:',
                    'Levanta el tronco y la cabeza apoyándose en manos y antebrazos, mantiene erguida y firme la cabeza, se mantiene sentado con apoyo, se sienta solo sin apoyo.',
                    motoraPuntaje,
                    (value) {
                      setState(() {
                        motoraPuntaje = value;
                      });
                    },
                  ),
                  const SizedBox(height: 48),
                  Center(
                    child: ElevatedButton(
                      onPressed: mostrarResultado,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 20),
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text(
                        'Evaluar',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
