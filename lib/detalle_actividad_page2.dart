import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
    return lenguajePuntaje + socialPuntaje + coordinacionPuntaje + motoraPuntaje;
  }

    void mostrarResultado() {
    int puntajeTotal = calcularPuntajeTotal();
    if (puntajeTotal >= 12) { 
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Evaluación Completada'),
          content: const Text('El desarrollo del bebé está bien.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (puntajeTotal <= 4 ){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: const Text('Atencion al desarrollo'),
          content: const Text('El desarrollo se esta viendo afectado consulta un especialista'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text('Consulta'),
              ),
          ],
        ),
        );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Alerta de Desarrollo'),
          content: const Text('Hay áreas de desarrollo que necesitan atención. Por favor, agenda una cita.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Agendar Cita'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.actividad),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Lenguaje:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Balbucea. “Da-da”, “ma-ma”',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: lenguajePuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: lenguajePuntaje.toString(),
                onChanged: (double value) {
                  setState(() {
                    lenguajePuntaje = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 34),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Social:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Atiende con interés al sonido, busca con interés el sonido, sonríe espontáneamente',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: socialPuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: socialPuntaje.toString(),
                onChanged: (double value) {
                  setState(() {
                    socialPuntaje = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Coordinación:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Intenta la prensión de objetos, prensión global a mano plena (Barrido)',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: coordinacionPuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: coordinacionPuntaje.toString(),
                onChanged: (double value) {
                  setState(() {
                    coordinacionPuntaje = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 30),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(fontSize: 20),
                  children: <TextSpan> [
                    TextSpan(text: 'Motora:',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' Levanta el tronco y la cabeza apoyándose en manos y antebrazos, mantiene erguida y firme la cabeza, se mantiene sentado con apoyo, se sienta solo sin apoyo.',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                    ),
                  ],
                ),
              ),
              Slider(
                value: motoraPuntaje.toDouble(),
                min: 0,
                max: 3,
                divisions: 3,
                label: motoraPuntaje.toString(),
                onChanged: (double value) {
                  setState(() {
                    motoraPuntaje = value.toInt();
                  });
                },
              ),
              const SizedBox(height: 80),
                Image.asset(
                  'assets/images/system-regular-56-warning.gif',
                  width: 70,
                  height: 70,
                ).animate().fadeIn(),
                const SizedBox(height: 20),
                const Text(
                  'Datos de alarma: No reacciona ante los sonidos de alrededor, no emite sonidos de vocales, tiene dificultad para llevarse cosas a la boca, no rueda en ninguna dirección para darse vuelta, se ve rígido y con los músculos tensos',
                  style: TextStyle(fontSize: 18),
                ).animate().fadeIn(delay: const Duration(milliseconds: 500),
              ),
              const SizedBox(height: 80),
              ElevatedButton(
                onPressed: mostrarResultado,
                child: const Text('Evaluar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}