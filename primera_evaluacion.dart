import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrimeraEvaluacionPage extends StatefulWidget {
  @override
  _PrimeraEvaluacionPageState createState() => _PrimeraEvaluacionPageState();
}

class _PrimeraEvaluacionPageState extends State<PrimeraEvaluacionPage> {
  final List<String> preguntas = [
    "¿Responde al sonido de tu voz?",
    "¿Mueve la cabeza hacia ambos lados?",
    "¿Levanta la cabeza cuando está boca abajo?",
    "¿Sonríe en respuesta a tu sonrisa?",
    "¿Sigue objetos con la vista?",
    "¿Emite sonidos o balbucea?",
    "¿Reacciona al contacto físico?",
    "¿Abre y cierra las manos?",
    "¿Intenta agarrar objetos cercanos?",
    "¿Muestra interés por su entorno?"
  ];

  final List<int> respuestas = List.filled(10, 0); // Almacena las respuestas seleccionadas
  final List<String> opciones = ["Nunca", "Casi nunca", "A veces", "Casi siempre", "Siempre"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primera Evaluación'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Por favor, responde las siguientes preguntas:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: preguntas.length,
                itemBuilder: (context, index) {
                  return _buildPregunta(index);
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _guardarEvaluacion,
              child: const Text('Completar Evaluación'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPregunta(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${index + 1}. ${preguntas[index]}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(opciones.length, (i) {
                return RadioListTile<int>(
                  title: Text(opciones[i]),
                  value: i,
                  groupValue: respuestas[index],
                  onChanged: (value) {
                    setState(() {
                      respuestas[index] = value!;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _guardarEvaluacion() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Guardar respuestas en SharedPreferences para futuras consultas
    await prefs.setStringList(
      'respuestasPrimeraEvaluacion',
      respuestas.map((r) => r.toString()).toList(),
    );

    // Mostrar un diálogo de confirmación
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Evaluación Completada'),
          content: const Text('Gracias por completar la evaluación.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }
}

