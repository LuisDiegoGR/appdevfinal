import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Evaluacion4MesPage extends StatefulWidget {
  @override
  _Evaluacion4MesesPageState createState() => _Evaluacion4MesesPageState();
}

class _Evaluacion4MesesPageState extends State<Evaluacion4MesPage> {
  final _formKey = GlobalKey<FormState>();
  final Map<String, String> _responses = {};
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _folioController = TextEditingController();

  // Mensaje amigable para el usuario
  String _generateResultMessage() {
    String resultMessage = "✨ Resultado de la evaluación:\n\n";

    _responses.forEach((key, value) {
      switch (key) {
        case 'estimulo_fuerte':
          resultMessage += value == 'No'
              ? '🚨 Tu bebé **no responde aún a estímulos fuertes**. Consulta con tu pediatra si tienes dudas. 💕\n\n'
              : '😊 ¡Excelente! Tu bebé responde a estímulos fuertes. 🌟\n\n';
          break;
        case 'sigue_vista':
          resultMessage += value == 'No'
              ? '👀 Tu bebé aún no sigue objetos con la vista. Revisión recomendada. 🍼\n\n'
              : '🥰 Tu bebé sigue con la vista objetos en movimiento. 🌈\n\n';
          break;
        case 'manos_boca':
          resultMessage += value == 'No'
              ? '✋👄 Todavía no se lleva las manos a la boca. Observa su desarrollo 💖\n\n'
              : '👏 ¡Genial! Se lleva las manos a la boca. 🌸\n\n';
          break;
        case 'sostener_cabeza':
          resultMessage += value == 'No'
              ? '🧸 Aún no sostiene la cabeza al estar boca abajo. Consulta con tu pediatra 💕\n\n'
              : '💪 ¡Perfecto! Sostiene la cabeza. 🌟\n\n';
          break;
      }
    });

    return resultMessage;
  }

  Future<void> _saveToFirebase() async {
    final String nombreBebe = _nombreController.text.trim();
    final String folio = _folioController.text.trim();

    if (nombreBebe.isEmpty || folio.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('💡 Ingresa el nombre del bebé y el folio.'),
          backgroundColor: Colors.pinkAccent,
        ),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('evaluacion4Meses').add({
        'nombreBebe': nombreBebe,
        'folio': folio,
        'fechaEvaluacion': DateTime.now().toIso8601String(),
        'respuestas': _responses,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('✅ Resultados guardados exitosamente.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('❌ Error al guardar los resultados: $e'),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  List<Widget> _buildQuestionFields() {
    return [
      _buildQuestionCard('¿Responde a estímulos fuertes?', 'estimulo_fuerte'),
      _buildQuestionCard('¿Sigue con la vista las cosas que se mueven?', 'sigue_vista'),
      _buildQuestionCard('¿Se lleva las manos a la boca?', 'manos_boca'),
      _buildQuestionCard(
          '¿Puede sostener la cabeza en alto cuando empuja el cuerpo hacia arriba estando boca abajo?',
          'sostener_cabeza'),
    ];
  }

  Widget _buildQuestionCard(String label, String keyName) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 6,
      margin: EdgeInsets.symmetric(vertical: 8),
      shadowColor: Colors.pinkAccent.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
        child: DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: label,
            border: InputBorder.none,
          ),
          items: ['Sí', 'No']
              .map((value) => DropdownMenuItem(value: value, child: Text(value)))
              .toList(),
          onChanged: (value) {
            setState(() {
              _responses[keyName] = value ?? '';
            });
          },
          validator: (value) =>
              value == null || value.isEmpty ? 'Por favor selecciona una respuesta.' : null,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        title: Text('Evaluación de 4 Meses'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pink.shade200, Colors.pinkAccent.shade400],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.shade200.withOpacity(0.6),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Completa la evaluación de tu bebé con cariño 💕',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 20),
                    _buildTextField(_nombreController, '👶 Nombre del bebé'),
                    SizedBox(height: 12),
                    _buildTextField(_folioController, '🔑 Folio'),
                    SizedBox(height: 20),
                    ..._buildQuestionFields(),
                    SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16),
                        elevation: 6,
                      ),
                      onPressed: () {
                        if (_formKey.currentState?.validate() == true) {
                          _saveToFirebase();
                          final resultMessage = _generateResultMessage();
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              title: Text('🌼 Resultados'),
                              content: SingleChildScrollView(
                                child: Text(
                                  resultMessage,
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: Text('Cerrar ❤️'),
                                ),
                              ],
                            ),
                          );
                        }
                      },
                      child: Text(
                        '✨ Mostrar Resultados',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) =>
          value == null || value.trim().isEmpty ? 'Por favor ingresa $label' : null,
    );
  }
}








