import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'page_estimulacion.dart';

class EncuestaPage extends StatefulWidget {
  const EncuestaPage({super.key});

  @override
  State<EncuestaPage> createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<EncuestaPage> {
  final List<String> preguntas = [
    '¿En su familia alguien tuvo preeclampsia o eclampsia?',
    '¿Antes de su embarazo usted tenía hipertensión arterial?',
    '¿Le diagnosticaron hipertensión gestacional?',
    '¿Antes de su embarazo usted era portadora de diabetes mellitus?',
    '¿Durante su embarazo le diagnosticaron diabetes gestacional?',
    '¿Tiene alguna enfermedad autoinmune? (LUPUS, Síndrome antifosfolípidos, enfermedad de tiroides, enfermedad renal)',
    '¿Cuál era su peso antes del embarazo y después del embarazo?',
    '¿Cuál es su ocupación?',
    '¿Durante su embarazo le hicieron pruebas correspondientes a detección de enfermedades de transmisión sexual?',
    '¿Durante su embarazo usted consumió alguna droga?',
    '¿Curso con alguna infección?',
    '¿Tuvo una red de apoyo durante su embarazo?',
    '¿Durante su embarazo tuvo algún accidente?',
    '¿Durante su embarazo pasó por un momento de alto estrés emocional?',
    '¿Ha tenido alguna muerte fetal o neonatal en embarazos anteriores?',
    '¿Tuvo alguna cirugía en el tracto reproductivo?',
    '¿Tuvo isoinmunización (Tipo de sangre Rh -) en el embarazo actual o en anteriores?'
  ];

  Map<String, String?> respuestas = {};
  int currentQuestionIndex = 0;
  final PageController _pageController = PageController();
  final Map<String, TextEditingController> controllers = {};
  String? mensajeError;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // ====================== Guardar resultado y enviar a Firebase ======================
Future<void> _guardarResultado() async {
  final prefs = await SharedPreferences.getInstance();

  // Evaluar riesgo considerando las preguntas de bajo riesgo
  bool esAltoRiesgo = false;

  for (var entry in respuestas.entries) {
    String pregunta = entry.key;
    String? respuesta = entry.value;

    // Si la respuesta es "Sí", normalmente es riesgo, excepto las de bajo riesgo
    if (respuesta == 'Sí') {
      // Estas preguntas se consideran de bajo riesgo aunque respondan "Sí"
      if (pregunta == '¿Tuvo una red de apoyo durante su embarazo?' ||
          pregunta ==
              '¿Durante su embarazo le hicieron pruebas correspondientes a detección de enfermedades de transmisión sexual?') {
        continue; // No se cuenta como riesgo
      } else {
        esAltoRiesgo = true;
      }
    }
  }

  // Guardar desbloqueo de planes según riesgo
  prefs.setBool('desbloquearAvanzadas', esAltoRiesgo);
  prefs.setBool('desbloquearPlan', !esAltoRiesgo);

  // ====== MARCAR LA ENCUESTA COMO COMPLETADA ======
  prefs.setBool('encuestaCompletada', true);

  // ====================== Guardar en Firestore ======================
  try {
    User? user = _auth.currentUser;
    if (user != null) {
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(user.uid).get();

      if (userDoc.exists) {
        String name = userDoc['name'] ?? '';
        String lastName = userDoc['lastName'] ?? '';
        String fullName = "$name $lastName".trim();

        String resultadoFinal = esAltoRiesgo
            ? "PLAN CON FACTORES DE RIESGO"
            : "PLAN SIN FACTORES DE RIESGO";

        await _firestore.collection('encuesta').doc(fullName).set({
          'respuestas': respuestas,
          'resultado_final': resultadoFinal,
          'fecha': Timestamp.now(),
        });
      }
    }
  } catch (e) {
    print('Error al guardar en Firestore: $e');
  }

  // ====================== Mostrar diálogo de resultado ======================
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        elevation: 10,
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: esAltoRiesgo
                  ? [Colors.redAccent.shade200, Colors.red.shade700]
                  : [Colors.greenAccent.shade200, Colors.green.shade600],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 15,
                offset: Offset(0, 8),
              )
            ],
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                esAltoRiesgo ? Icons.warning_rounded : Icons.check_circle_rounded,
                size: 70,
                color: Colors.white,
              ),
              const SizedBox(height: 15),
              Text(
                esAltoRiesgo ? '¡ATENCIÓN!' : '¡FELICIDADES!',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.black38,
                      offset: Offset(1, 1),
                      blurRadius: 3,
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Text(
                esAltoRiesgo
                    ? 'Tu embarazo se considera de alto riesgo. Sigue cuidadosamente las actividades del plan de riesgo.'
                    : 'Tu embarazo no presenta factores de riesgo. Puedes seguir el plan de actividades estándar.',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => PageEstimulacion()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: esAltoRiesgo ? Colors.redAccent : Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                ),
                child: const Text(
                  'Aceptar',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
  // ====================== Tarjetas de preguntas ======================
  Widget _buildQuestionCard(String question, String key) {
    bool isPesoQuestion =
        question == '¿Cuál era su peso antes del embarazo y después del embarazo?';
    bool isTextQuestion = question == '¿Cuál es su ocupación?';
    bool isInfeccionQuestion = question == '¿Curso con alguna infección?';
    bool isIsoinmunizacionQuestion =
        question == '¿Tuvo isoinmunización (Tipo de sangre Rh -) en el embarazo actual o en anteriores?';

    if (isPesoQuestion) {
      controllers['pesoAntes'] ??= TextEditingController();
      controllers['pesoDespues'] ??= TextEditingController();
    } else if (isTextQuestion) {
      controllers[key] ??= TextEditingController();
    } else if (isInfeccionQuestion) {
      controllers['manejo'] ??= TextEditingController();
      controllers['semana'] ??= TextEditingController();
    }

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: const Color(0xFFFFF1E6),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.question_answer, size: 40, color: Colors.orangeAccent),
                const SizedBox(height: 10),
                Text(
                  question,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                // Campos especiales o respuestas normales
                if (isPesoQuestion) ...[
                  TextField(
                    controller: controllers['pesoAntes'],
                    decoration: const InputDecoration(
                      labelText: 'Peso antes del embarazo',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => respuestas['pesoAntes'] = value,
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: controllers['pesoDespues'],
                    decoration: const InputDecoration(
                      labelText: 'Peso después del embarazo',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => respuestas['pesoDespues'] = value,
                  ),
                ] else if (isTextQuestion) ...[
                  TextFormField(
                    controller: controllers[key],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Escribe aquí tu respuesta',
                    ),
                    onChanged: (value) => respuestas[key] = value,
                  )
                ] else if (isInfeccionQuestion) ...[
                  RadioListTile<String>(
                    title: const Text('Sí'),
                    value: 'Sí',
                    groupValue: respuestas[key],
                    onChanged: (value) {
                      setState(() {
                        respuestas[key] = value;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: const Text('No'),
                    value: 'No',
                    groupValue: respuestas[key],
                    onChanged: (value) {
                      setState(() {
                        respuestas[key] = value;
                      });
                      Future.delayed(const Duration(milliseconds: 300), () {
                        setState(() {
                          mensajeError = null;
                          if (currentQuestionIndex < preguntas.length - 1) {
                            currentQuestionIndex++;
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _guardarResultado();
                          }
                        });
                      });
                    },
                  ),
                  if (respuestas[key] == 'Sí') ...[
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controllers['manejo'],
                      decoration: const InputDecoration(
                        labelText: '¿Se le dio manejo?',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => respuestas['manejo'] = value,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: controllers['semana'],
                      decoration: const InputDecoration(
                        labelText: '¿En qué semana?',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) => respuestas['semana'] = value,
                    ),
                  ]
                ] else ...[
                  RadioListTile<String>(
                    title: const Text('Sí'),
                    value: 'Sí',
                    groupValue: respuestas[key],
                    onChanged: (value) => setState(() {
                      respuestas[key] = value;
                    }),
                  ),
                  RadioListTile<String>(
                    title: const Text('No'),
                    value: 'No',
                    groupValue: respuestas[key],
                    onChanged: (value) => setState(() {
                      respuestas[key] = value;
                    }),
                  ),
                  if (isIsoinmunizacionQuestion)
                    RadioListTile<String>(
                      title: const Text('No aplica'),
                      value: 'No aplica',
                      groupValue: respuestas[key],
                      onChanged: (value) => setState(() {
                        respuestas[key] = value;
                      }),
                    ),
                ],

                const SizedBox(height: 20),
                if (mensajeError != null)
                  Text(
                    mensajeError!,
                    style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                const SizedBox(height: 10),

                // Botones
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    if (currentQuestionIndex > 0)
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            mensajeError = null;
                            currentQuestionIndex--;
                            _pageController.previousPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Anterior'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                        ),
                      ),
                    ElevatedButton.icon(
                      onPressed: () {
                        var respuestaActual = respuestas[key];
                        if (isPesoQuestion) {
                          if (controllers['pesoAntes']!.text.isEmpty ||
                              controllers['pesoDespues']!.text.isEmpty) {
                            setState(() => mensajeError = 'Completa ambos campos');
                            return;
                          }
                        } else if (isTextQuestion &&
                            controllers[key]!.text.isEmpty) {
                          setState(
                              () => mensajeError = 'Es necesario responder esta pregunta');
                          return;
                        } else if (isInfeccionQuestion &&
                            respuestaActual == 'Sí' &&
                            (controllers['manejo']!.text.isEmpty ||
                                controllers['semana']!.text.isEmpty)) {
                          setState(() => mensajeError =
                              'Completa los campos de manejo y semana antes de continuar');
                          return;
                        } else if (!isPesoQuestion &&
                            !isTextQuestion &&
                            !isInfeccionQuestion &&
                            respuestaActual == null) {
                          setState(
                              () => mensajeError = 'Es necesario responder la pregunta');
                          return;
                        }

                        setState(() {
                          mensajeError = null;
                          if (currentQuestionIndex < preguntas.length - 1) {
                            currentQuestionIndex++;
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _guardarResultado();
                          }
                        });
                      },
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(currentQuestionIndex < preguntas.length - 1
                          ? 'Siguiente'
                          : 'Finalizar'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.greenAccent,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ====================== Build principal ======================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Encuesta de Evaluación'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'Responde las siguientes preguntas para evaluar el nivel de riesgo en tu embarazo.',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: preguntas.length,
                itemBuilder: (context, index) {
                  return _buildQuestionCard(preguntas[index], preguntas[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}