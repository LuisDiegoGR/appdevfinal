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

  // Método para calcular el puntaje total
  int calcularPuntajeTotal() {
    return lenguajePuntaje + socialPuntaje + coordinacionPuntaje + motoraPuntaje;
  }

  // Método para mostrar el resultado basado en el puntaje total
  void mostrarResultado() {
    int puntajeTotal = calcularPuntajeTotal();

    if (puntajeTotal >= 16) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Evaluación Completada',
        text: 'El desarrollo del bebé está bien.',
        confirmBtnText: 'OK',
      );
    } else if (puntajeTotal >= 9 && puntajeTotal <= 15) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.info,
        title: 'Atención al Desarrollo',
        text: 'Hay algunas áreas que necesitan atención.',
        confirmBtnText: 'Consultar especialista',
        onConfirmBtnTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) =>  ConsultarEspecialista()),
        ),
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: 'Alerta de Desarrollo',
        text: 'El desarrollo se está viendo afectado. Consulta a un especialista de inmediato.',
        confirmBtnText: 'Agendar Cita',
        onConfirmBtnTap: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const Citas()),
        ),
      );
    }
  }

  // Método para crear un widget de evaluación por categoría
  Widget _buildEvaluacionCategoria(
      String title, String description, int value, ValueChanged<int> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF4CAF50),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: const TextStyle(color: Colors.black87, fontSize: 16),
            ),
            const SizedBox(height: 12),
            DropdownButton<int>(
              value: value == 0 ? null : value,
              hint: const Text("Selecciona una opción (1 a 5)"),
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text(
                    "1: No lo hace",
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
                DropdownMenuItem(
                  value: 2,
                  child: Text(
                    "2: Casi lo hace",
                    style: const TextStyle(color: Colors.orange),
                  ),
                ),
                DropdownMenuItem(
                  value: 3,
                  child: Text(
                    "3: A veces lo hace",
                    style: const TextStyle(color: Colors.yellow),
                  ),
                ),
                DropdownMenuItem(
                  value: 4,
                  child: Text(
                    "4: Casi lo hace",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                DropdownMenuItem(
                  value: 5,
                  child: Text(
                    "5: Lo hace",
                    style: const TextStyle(color: Colors.green),
                  ),
                ),
              ],
              onChanged: (newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
              dropdownColor: Colors.pink[50],
              iconEnabledColor: Colors.pink,
              isExpanded: true,
              style: const TextStyle(color: Colors.black, fontSize: 16),
            ),
          ],
        ),
      ),
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
                        icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      const SizedBox(height: 30),
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
                  const SizedBox(height: 20),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Ponderación de la Actividad',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          _buildEvaluacionCategoria(
                            "Lenguaje",
                            "Evaluar las habilidades de lenguaje del bebé.",
                            lenguajePuntaje,
                            (newValue) {
                              setState(() {
                                lenguajePuntaje = newValue;
                              });
                            },
                          ),
                          _buildEvaluacionCategoria(
                            "Social",
                            "Evaluar las habilidades sociales del bebé.",
                            socialPuntaje,
                            (newValue) {
                              setState(() {
                                socialPuntaje = newValue;
                              });
                            },
                          ),
                          _buildEvaluacionCategoria(
                            "Coordinación",
                            "Evaluar la coordinación motriz del bebé.",
                            coordinacionPuntaje,
                            (newValue) {
                              setState(() {
                                coordinacionPuntaje = newValue;
                              });
                            },
                          ),
                          _buildEvaluacionCategoria(
                            "Motora",
                            "Evaluar las habilidades motrices del bebé.",
                            motoraPuntaje,
                            (newValue) {
                              setState(() {
                                motoraPuntaje = newValue;
                              });
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: mostrarResultado,
                            child: const Text('Mostrar Resultado'),
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
      ),
    );
  }
}




