import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DetalleActividadPage3 extends StatefulWidget {
  const DetalleActividadPage3({super.key, required this.actividad});
  final String actividad;

  @override
  State<DetalleActividadPage3> createState() => _DetalleActividadPage3State();
}

class _DetalleActividadPage3State extends State<DetalleActividadPage3> {
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
                    TextSpan(text: ' Lalea, “da-da”, “ma-ma”, “Agu”, utiliza las consonantes',
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
                    TextSpan(text: ' Encuentra objetos que se le ocultan bajo el pañal, es inicialmente tímido con extraños.',
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
              const SizedBox(height: 34),
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
                    TextSpan(text: ' Prensión entre la base del pulgar y el meñique, presión entre el pulgar y la base del dedo índice, prensión en pinza fina, opone el índice al pulgar ',
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
              const SizedBox(height: 34),
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
                    TextSpan(text: ' Se sienta solo sin apoyo, consigue pararse a apoyado en muebles, Gatea, camina apoyado en muebles',
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
                  'Datos de alarma: No se sienta con ayuda, no balbucea, no responde cuando le llaman por su nombre, no se sostiene en las piernas de apoyo. ',
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