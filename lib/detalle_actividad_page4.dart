import 'package:flutter/material.dart';

class DetalleActividadPage4 extends StatefulWidget {
  const DetalleActividadPage4({super.key, required this.actividad});
  final String actividad;

  @override
  State<DetalleActividadPage4> createState() => _DetalleActividadPage4State();
}

class _DetalleActividadPage4State extends State<DetalleActividadPage4> {
  // Variables para almacenar puntajes
  int lenguajePuntaje = 0;
  int socialPuntaje = 0;
  int coordinacionPuntaje = 0;
  int motoraPuntaje = 0;

  // Método para calcular el puntaje total
  int calcularPuntajeTotal() {
    return lenguajePuntaje + socialPuntaje + coordinacionPuntaje + motoraPuntaje;
  }

  // Método para mostrar el resultado
  void mostrarResultado() {
    int puntajeTotal = calcularPuntajeTotal();
    if (puntajeTotal >= 12) { // Suponiendo que el puntaje máximo por categoría es 3
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Evaluación Completada'),
          content: Text('El desarrollo del bebé está bien.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } else if (puntajeTotal <= 4 ){
      showDialog(
        context: context, 
        builder: (context) => AlertDialog(
          title: Text('Atencion al desarrollo'),
          content: Text('El desarrollo se esta viendo afectado consulta un especialista'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: Text('Consulta'),
              ),
          ],
        ),
        );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Alerta de Desarrollo'),
          content: Text('Hay áreas de desarrollo que necesitan atención. Por favor, agenda una cita.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // Aquí puedes agregar la lógica para agendar una cita
              },
              child: Text('Agendar Cita'),
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
                text: TextSpan(
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
              SizedBox(height: 34),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
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
              SizedBox(height: 34),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
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
              SizedBox(height: 34),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
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
              SizedBox(height: 80),
              ElevatedButton(
                onPressed: mostrarResultado,
                child: Text('Evaluar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
