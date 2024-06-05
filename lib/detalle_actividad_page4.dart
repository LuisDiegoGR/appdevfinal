import 'package:flutter/material.dart';

class DetalleActividadPage4 extends StatefulWidget {
  const DetalleActividadPage4({super.key, required this.actividad});
  final String actividad;

  @override
  State<DetalleActividadPage4> createState() => _DetalleActividadPage4State();
}

class _DetalleActividadPage4State extends State<DetalleActividadPage4> {
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
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Lenguaje:',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Dada, mamá, pan, agua, oso.',
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
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Social:',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Bebe de la tasa, detiene la acción a la orden de ¡No!',
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
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Coordinación:',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Prensión en pinza fina. Opone el índice al pulgar ',
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
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Motora:',
                      style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' Gatea, camina apoyado en muebles, camina tomado de la mano.',
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
