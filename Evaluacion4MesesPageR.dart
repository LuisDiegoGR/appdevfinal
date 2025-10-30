import 'package:flutter/material.dart';

class Evaluacion4MesesPageR extends StatefulWidget {
  const Evaluacion4MesesPageR({super.key});

  @override
  _Evaluacion4MesesPageRState createState() => _Evaluacion4MesesPageRState();
}

class _Evaluacion4MesesPageRState extends State<Evaluacion4MesesPageR> {
  final Map<String, int> _respuestas = {
    "Balbucea. “Da-da”, “ma-ma\"": 0,
    "Atiende con interés al sonido, busca con interés el sonido, sonríe espontáneamente": 0,
    "Intenta la prensión de objetos, prensión global a mano plena (Barrido)": 0,
    "Levanta el tronco y la cabeza apoyándose en manos y antebrazos": 0,
    "Mantiene erguida y firme la cabeza": 0,
    "Se mantiene sentado con apoyo": 0,
    "Se sienta solo sin apoyo": 0,
  };

  int _puntajeTotal() {
    return _respuestas.values.fold(0, (sum, value) => sum + value);
  }

  String _calcularResultado() {
    int puntaje = _puntajeTotal();
    if (puntaje > 12) {
      return "Verde: Sin alteración";
    } else if (puntaje >= 6) {
      return "Amarillo: Posible alteración";
    } else {
      return "Rojo: Necesita atención inmediata";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación 4to Mes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Evalúe los siguientes comportamientos del bebé:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: _respuestas.keys.map((pregunta) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pregunta,
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          for (var i = 1; i <= 4; i++)
                            Expanded(
                              child: RadioListTile<int>(
                                title: Text(
                                  ["Nunca", "Casi nunca", "A veces", "Casi siempre"][i - 1],
                                  style: const TextStyle(fontSize: 14),
                                ),
                                value: i,
                                groupValue: _respuestas[pregunta],
                                onChanged: (value) {
                                  setState(() {
                                    _respuestas[pregunta] = value!;
                                  });
                                },
                              ),
                            ),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String resultado = _calcularResultado();
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Resultado de la Evaluación'),
                      content: Text(
                        resultado,
                        style: const TextStyle(fontSize: 18),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text('Cerrar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text('Calcular Resultado'),
            ),
          ],
        ),
      ),
    );
  }
}

