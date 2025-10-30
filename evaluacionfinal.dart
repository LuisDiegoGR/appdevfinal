import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EvaluacionFinalPage extends StatefulWidget {
  const EvaluacionFinalPage({Key? key}) : super(key: key);

  @override
  State<EvaluacionFinalPage> createState() => _EvaluacionFinalPageState();
}

class _EvaluacionFinalPageState extends State<EvaluacionFinalPage> {
  final Map<String, String> _responses = {};
  final Map<String, int> _scoring = {
    "Nunca": 0,
    "Casi nunca": 1,
    "A veces": 2,
    "Casi siempre": 3,
    "Siempre": 4,
  };

  final TextEditingController _babyNameController = TextEditingController();
  final TextEditingController _folioController = TextEditingController();

  // Variables para almacenar las puntuaciones de las categorías
  int _puntuacionLenguaje = 0;
  int _puntuacionCoordinacion = 0;
  int _puntuacionMotor = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evaluación Final'),
        backgroundColor: Colors.deepOrange,
        elevation: 8,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        color: Colors.orange[50],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeaderSection(),
            const SizedBox(height: 20),

            // Nombre del bebé
            TextField(
              controller: _babyNameController,
              decoration: const InputDecoration(
                labelText: 'Nombre del bebé',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            // Folio
            TextField(
              controller: _folioController,
              decoration: const InputDecoration(
                labelText: 'Folio',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildQuestionTile('¿El bebé responde a estímulos auditivos?', 'q1', 'lenguaje'),
                  _buildQuestionTile('¿Mantiene contacto visual durante el juego?', 'q2', 'lenguaje'),
                  _buildQuestionTile('¿Puede mantenerse sentado sin apoyo por algunos segundos?', 'q3', 'coordinacion'),
                  _buildQuestionTile('¿Realiza movimientos con ambas manos de manera coordinada?', 'q4', 'coordinacion'),
                  _buildQuestionTile('¿Responde con vocalizaciones o sonidos a estímulos emocionales?', 'q5', 'lenguaje'),
                  _buildQuestionTile('¿Se desplaza gateando o arrastrándose?', 'q6', 'motor'),
                  _buildQuestionTile('¿Puede mantener el equilibrio al estar de pie con apoyo?', 'q7', 'motor'),
                ],
              ),
            ),
            const SizedBox(height: 30),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: const [
          Text(
            'Evaluación Final',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 10),
          Text(
            'Completa la evaluación seleccionando una opción para cada pregunta.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black87,
            ),
            textAlign: TextAlign.justify,
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionTile(String question, String key, String category) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.orange[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Column(
            children: _scoring.keys.map((option) {
              return RadioListTile<String>(
                title: Text(option),
                value: option,
                groupValue: _responses[key],
                onChanged: (String? value) {
                  setState(() {
                    _responses[key] = value!;
                    int score = _scoring[value]!;

                    if (category == 'lenguaje') {
                      _puntuacionLenguaje += score;
                    } else if (category == 'coordinacion') {
                      _puntuacionCoordinacion += score;
                    } else if (category == 'motor') {
                      _puntuacionMotor += score;
                    }
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () async {
        if (_babyNameController.text.isEmpty) {
          _showErrorDialog('Por favor, ingresa el nombre del bebé.');
          return;
        }
        if (_folioController.text.isEmpty) {
          _showErrorDialog('Por favor, ingresa el folio.');
          return;
        }
        if (_responses.length < 7) {
          _showErrorDialog('Por favor, responde todas las preguntas antes de continuar.');
          return;
        }

        final totalScore = _puntuacionLenguaje + _puntuacionCoordinacion + _puntuacionMotor;

        // 🔍 Verificar duplicados en Firebase
        final snapshot = await FirebaseFirestore.instance
            .collection('evaluacion6mesesamarillo')
            .where('nombreBebe', isEqualTo: _babyNameController.text)
            .get();

        final folioSnapshot = await FirebaseFirestore.instance
            .collection('evaluacion6mesesamarillo')
            .where('folio', isEqualTo: _folioController.text)
            .get();

        if (snapshot.docs.isNotEmpty || folioSnapshot.docs.isNotEmpty) {
          _showErrorDialog('El nombre o el folio ya están registrados.');
          return;
        }

        _saveToFirebase(totalScore);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        backgroundColor: Colors.deepOrange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: const Text(
        'Finalizar Evaluación',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar'),
            ),
          ],
        );
      },
    );
  }

  void _saveToFirebase(int totalScore) async {
    String result;
    if (totalScore >= 16) {
      result = "Verde";
    } else if (totalScore >= 6) {
      result = "Amarillo";
    } else {
      result = "Rojo";
    }

    await FirebaseFirestore.instance.collection('evaluacion6mesesamarillo').add({
      'nombreBebe': _babyNameController.text,
      'folio': _folioController.text,
      'resultado': result,
      'puntuacion': totalScore,
      'lenguaje': _puntuacionLenguaje,
      'coordinacion': _puntuacionCoordinacion,
      'motor': _puntuacionMotor,
      'fecha': Timestamp.now(),
    });

    _showResultDialog(totalScore, result);
  }

  void _showResultDialog(int totalScore, String result) {
    String description;
    Color bgColor;

    if (result == "Verde") {
      description = '¡El desarrollo del bebé es óptimo!';
      bgColor = Colors.green;
    } else if (result == "Amarillo") {
      description = 'Hay aspectos a reforzar. Considera actividades adicionales.';
      bgColor = Colors.yellow[700]!;
    } else {
      description = 'Es importante buscar orientación especializada.';
      bgColor = Colors.red;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: bgColor,
          title: const Text('Resultado de la Evaluación', style: TextStyle(color: Colors.white)),
          content: Text(description, style: const TextStyle(color: Colors.white)),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}



















