import 'package:appdevfinal/chatbot.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart'; // ✅ Agregado

class Evaluacion3MesesPage extends StatefulWidget {
  const Evaluacion3MesesPage({Key? key}) : super(key: key);

  @override
  _Evaluacion3MesesPageState createState() => _Evaluacion3MesesPageState();
}

class _Evaluacion3MesesPageState extends State<Evaluacion3MesesPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final List<int> respuestas = List.filled(6, 0);
  final TextEditingController _nombreBebeController = TextEditingController();
  final TextEditingController _folioController = TextEditingController();

  int calcularPuntajeTotal() => respuestas.reduce((a, b) => a + b);
  int calcularPuntajeLenguaje() => respuestas[0] + respuestas[1];
  int calcularPuntajeCoordinacion() => respuestas[2] + respuestas[3];
  int calcularPuntajeMotor() => respuestas[4] + respuestas[5];

  void mostrarError(String mensaje) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('⚠ Aviso'),
        content: Text(mensaje),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  Future<void> guardarResultadoVerificandoDuplicados(String resultado, int puntaje) async {
    final String nombreBebe = _nombreBebeController.text.trim();
    final String folio = _folioController.text.trim();

    if (nombreBebe.isEmpty || folio.isEmpty) {
      mostrarError('Por favor, ingresa el nombre del bebé y el folio antes de continuar.');
      return;
    }

    final snapshot = await _firestore
        .collection('evaluaciones')
        .where('nombre_bebe', isEqualTo: nombreBebe)
        .where('folio', isEqualTo: folio)
        .get();

    if (snapshot.docs.isNotEmpty) {
      mostrarError('⚠ Ya existe una evaluación registrada con este nombre y folio.');
      return;
    }

    await _firestore.collection('evaluaciones').add({
      'nombre_bebe': nombreBebe,
      'folio': folio,
      'resultado': resultado,
      'puntuacion': puntaje,
      'lenguaje': calcularPuntajeLenguaje(),
      'coordinacion': calcularPuntajeCoordinacion(),
      'motor': calcularPuntajeMotor(),
      'fecha': Timestamp.now(),
    });
  }

  void mostrarResultado() async {
    int puntajeTotal = calcularPuntajeTotal();
    String resultado;

    // ✅ Guardar progreso local (desbloquear botón en Actividades2Page)
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('evaluacion_3meses_completada', true);

    if (puntajeTotal > 15) {
      resultado = "Verde";
      await guardarResultadoVerificandoDuplicados(resultado, puntajeTotal);
      mostrarDialogoResultado(
        titulo: '¡Excelente! ✅',
        mensaje: 'El desarrollo del bebé está bien. Sin alteración aparente.',
        color: Colors.green,
        imagen: 'assets/images/excelente.jpg',
      );
    } else {
      resultado = "Amarillo";
      await guardarResultadoVerificandoDuplicados(resultado, puntajeTotal);
      mostrarDialogoResultado(
        titulo: 'Atención ⚠',
        mensaje: 'Aparente alteración en el desarrollo. Se recomienda dar seguimiento.',
        color: Colors.amber,
        imagen: 'assets/images/atencion.jpg',
        botonAdicional: true,
      );
    }
  }

  void mostrarDialogoResultado({
    required String titulo,
    required String mensaje,
    required Color color,
    required String imagen,
    bool botonAdicional = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          titulo,
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(imagen, height: 150, width: 150, fit: BoxFit.cover),
            const SizedBox(height: 20),
            Text(
              mensaje,
              style: const TextStyle(color: Colors.white, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          if (botonAdicional)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => GeminiChatBot()),
                );
              },
              child: const Text('Consultar', style: TextStyle(color: Colors.white)),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Aceptar', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2FEFA), Color(0xFF0ED2F7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Evaluación 3 Meses 🍼',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal.shade900,
                    shadows: const [
                      Shadow(blurRadius: 4, color: Colors.black26, offset: Offset(2, 2))
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildTextField(_nombreBebeController, 'Nombre del bebé', Icons.child_care),
                const SizedBox(height: 12),
                _buildTextField(_folioController, 'Folio', Icons.confirmation_num),
                const SizedBox(height: 20),
                const Text(
                  'Selecciona una opción para cada pregunta:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(children: _buildPreguntas()),
                  ),
                ),
                const SizedBox(height: 20),
                _buildEvaluarButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.teal),
          labelText: label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  Widget _buildEvaluarButton() {
    return ElevatedButton(
      onPressed: mostrarResultado,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 36),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 6,
        backgroundColor: Colors.teal.shade700,
      ),
      child: const Text(
        'Evaluar',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  List<Widget> _buildPreguntas() {
    const preguntas = [
      'Llora, emite sonidos',
      'Sonríe espontáneamente, reconoce sonidos',
      'Mira la cara, sigue con la mirada objetos móviles, busca con la mirada la fuente del sonido',
      'Mueve la cabeza y los ojos en busca del sonido',
      'Levanta 45 grados la cabeza y mantiene erguida y firme la cabeza',
      'Boca abajo, tracciona hasta sentarse'
    ];

    return List<Widget>.generate(preguntas.length, (index) {
      return Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              preguntas[index],
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              children: List.generate(5, (i) {
                return RadioListTile<int>(
                  title: Text(['Nunca', 'Casi nunca', 'A veces', 'Casi siempre', 'Siempre'][i]),
                  value: i + 1,
                  groupValue: respuestas[index],
                  onChanged: (value) {
                    setState(() {
                      respuestas[index] = value ?? 0;
                    });
                  },
                );
              }),
            ),
          ],
        ),
      );
    });
  }
}

