import 'package:flutter/material.dart';

class CuartaEvaluacionPage extends StatefulWidget {
  const CuartaEvaluacionPage({Key? key}) : super(key: key);

  @override
  _CuartaEvaluacionPageState createState() => _CuartaEvaluacionPageState();
}

class _CuartaEvaluacionPageState extends State<CuartaEvaluacionPage> {
  final List<String> preguntas = [
    "¿Se sienta con apoyo durante unos segundos?",
    "¿Se gira de boca arriba a boca abajo con facilidad?",
    "¿Mantiene la atención en un objeto o persona por más tiempo?",
    "¿Reacciona con risas o sonidos al ser estimulado?",
    "¿Puede sostener objetos pequeños con ambas manos?",
    "¿Busca la fuente de un sonido al escucharlo?",
    "¿Reconoce caras familiares y se emociona al verlas?",
    "¿Intenta imitar sonidos o balbuceos simples?",
    "¿Muestra preferencia por ciertos juguetes o colores?",
    "¿Intenta pasar un objeto de una mano a otra?"
  ];

  final List<int> respuestas = List.filled(10, 0);
  final List<String> opciones = ["Nunca", "Casi nunca", "A veces", "Casi siempre", "Siempre"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cuarta Evaluación'),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.tealAccent, Colors.teal],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Completa las siguientes preguntas:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
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
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.teal.shade700,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: _mostrarConfirmacion,
                child: const Text(
                  'Finalizar Evaluación',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPregunta(int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      color: Colors.white.withOpacity(0.9),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${index + 1}. ${preguntas[index]}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.teal),
            ),
            const SizedBox(height: 10),
            Column(
              children: List.generate(opciones.length, (i) {
                return RadioListTile<int>(
                  title: Text(
                    opciones[i],
                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                  ),
                  activeColor: Colors.teal,
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

  void _mostrarConfirmacion() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text('Evaluación Completada'),
          content: const Text(
            'Gracias por completar la evaluación. Tus respuestas han sido registradas.',
            style: TextStyle(fontSize: 16),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                'Aceptar',
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ],
        );
      },
    );
  }
}
