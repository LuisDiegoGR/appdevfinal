import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'actividad_agarremes3.dart';
import 'actividad_cuellomes3.dart';
import 'actividad_Desarrollomotrizmes3.dart';
import 'actividad_neurologicomes3.dart';
import 'actividad_audicionmes3.dart';
import 'actividad_vista_tactomes3.dart';
import 'evaluacion3meses.dart';
import 'package:intl/intl.dart';

class Mes3Riesgo extends StatefulWidget {
  const Mes3Riesgo({super.key});

  @override
  State<Mes3Riesgo> createState() => _Mes3RiesgoState();
}

class _Mes3RiesgoState extends State<Mes3Riesgo> {
  DateTime? _selectedDate;
  final Set<String> _completedSessions = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String nombreUsuario = '';

  final List<Widget Function()> _activityBuilders = [
    () => ActividadAgarreMes3(),
    () => ActividadCuelloMes3(),
    () => ActividadDesarrollomotrizMes3(),
    () => const ActividadNeurologicoMes3(),
    () => const ActividadAudicionMes3(),
    () => ActividadVistaTactoMes3(),
  ];

  final List<String> _estimulos = [
    'agarre',
    'cuello',
    'motriz',
    'neurologico',
    'audicion',
    'vista y tacto',
  ];

  @override
  void initState() {
    super.initState();
    _loadProgress();
    _cargarNombreUsuario();
  }

  Future<void> _cargarNombreUsuario() async {
  final user = _auth.currentUser;
  if (user != null) {
    final doc = await _firestore.collection('users').doc(user.uid).get();
    if (doc.exists) {
      final data = doc.data()!;
      final folio = data['folio'] ?? 'folio_desconocido'; // <- Cambiar aquí
      setState(() {
        nombreUsuario = folio; // <- Guardamos el folio en lugar del nombre
      });
    }
  }
}

  void _pickStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _saveStartDate();
        _saveProgressToFirebase();
      });
    }
  }

  void _openActivity(Widget activity, String sessionKey) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => activity),
    ).then((_) {
      setState(() {
        _completedSessions.add(sessionKey);
        _saveProgress();
        _saveProgressToFirebase();
      });
    });
  }

  bool _isMatutinaEnabled(int dayIndex, int todayIndex) {
    if (dayIndex == 0) return true;
    if (dayIndex > todayIndex) return false;
    return _completedSessions.contains("${dayIndex - 1}_matutina") &&
        _completedSessions.contains("${dayIndex - 1}_nocturna");
  }

  bool _isNocturnaEnabled(int dayIndex) {
    return _completedSessions.contains("${dayIndex}_matutina") ||
        _completedSessions.contains("${dayIndex}_nocturna");
  }

  String _getDayStatus(int index, int todayIndex) {
    final matutinaKey = "${index}_matutina";
    final nocturnaKey = "${index}_nocturna";

    final matutinaDone = _completedSessions.contains(matutinaKey);
    final nocturnaDone = _completedSessions.contains(nocturnaKey);

    if (matutinaDone && nocturnaDone) {
      if (index <= todayIndex) return "Estado: Completado 🤩";
      return "Estado: Realizado a destiempo ☹";
    } else if (matutinaDone || nocturnaDone) {
      if (index <= todayIndex) return "Estado: Casi completado 🤨";
      return "Estado: Realizado a destiempo ☹";
    } else {
      if (index < todayIndex) return "Estado: No realizado 😭";
      return "Estado: —";
    }
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('completedSessionsMes3', _completedSessions.toList());
  }

  Future<void> _saveStartDate() async {
    final prefs = await SharedPreferences.getInstance();
    if (_selectedDate != null) {
      prefs.setString('startDateMes3', _selectedDate!.toIso8601String());
    }
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final savedSessions = prefs.getStringList('completedSessionsMes3') ?? [];
    final savedDate = prefs.getString('startDateMes3');

    setState(() {
      _completedSessions.addAll(savedSessions);
      if (savedDate != null) {
        _selectedDate = DateTime.tryParse(savedDate);
      }
    });
  }

  Future<void> _saveProgressToFirebase() async {
    if (_selectedDate == null) return;

    final userId = nombreUsuario.isNotEmpty
        ? nombreUsuario
        : _auth.currentUser?.uid ?? 'usuario_demo';

    final progresoRef = _firestore.collection('progreso_mes3_3').doc(userId);

    await progresoRef.set({
      'fecha_inicio': _selectedDate!.toIso8601String(),
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    for (int i = 0; i < 30; i++) {
      DateTime fechaPlaneada = _selectedDate!.add(Duration(days: i));

      String estimuloMat = _estimulos[(i * 2) % _estimulos.length];
      String estimuloNoc = _estimulos[(i * 2 + 1) % _estimulos.length];

      String matKey = "${i}_matutina";
      bool matDone = _completedSessions.contains(matKey);
      String estadoMat = "pendiente";
      if (matDone) {
        estadoMat = (i <= DateTime.now().difference(_selectedDate!).inDays)
            ? "realizada a tiempo"
            : "realizada a destiempo";
      } else if (fechaPlaneada.isBefore(DateTime.now())) {
        estadoMat = "no completada";
      }

      await progresoRef.collection('actividades').doc('sesion_matutina_${i + 1}').set({
        'dia': i + 1,
        'sesion': 'matutina',
        'estado': estadoMat,
        'estimulo': estimuloMat,
        'fecha': fechaPlaneada.toIso8601String(),
        'fecha_realizacion': matDone ? DateTime.now().toIso8601String() : '',
        'usuario': nombreUsuario,
      }, SetOptions(merge: true));

      String nocKey = "${i}_nocturna";
      bool nocDone = _completedSessions.contains(nocKey);
      String estadoNoc = "pendiente";
      if (nocDone) {
        estadoNoc = (i <= DateTime.now().difference(_selectedDate!).inDays)
            ? "realizada a tiempo"
            : "realizada a destiempo";
      } else if (fechaPlaneada.isBefore(DateTime.now())) {
        estadoNoc = "no completada";
      }

      await progresoRef.collection('actividades').doc('sesion_nocturna_${i + 1}').set({
        'dia': i + 1,
        'sesion': 'nocturna',
        'estado': estadoNoc,
        'estimulo': estimuloNoc,
        'fecha': fechaPlaneada.toIso8601String(),
        'fecha_realizacion': nocDone ? DateTime.now().toIso8601String() : '',
        'usuario': nombreUsuario,
      }, SetOptions(merge: true));
    }
  }

  @override
  Widget build(BuildContext context) {
    int todayIndex = 0;
    if (_selectedDate != null) {
      todayIndex = DateTime.now().difference(_selectedDate!).inDays;
      todayIndex = todayIndex.clamp(0, 29);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes 3 - Actividades con Riesgo"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _selectedDate == null
            ? Center(
                child: ElevatedButton(
                  onPressed: _pickStartDate,
                  child: const Text("Escoge la fecha de inicio"),
                ),
              )
            : ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  final matutinaKey = "${index}_matutina";
                  final nocturnaKey = "${index}_nocturna";

                  final activityMatutina =
                      _activityBuilders[index % _activityBuilders.length]();
                  final activityNocturna =
                      _activityBuilders[(index + 1) % _activityBuilders.length]();

                  final matutinaEnabled = _isMatutinaEnabled(index, todayIndex);
                  final nocturnaEnabled = _isNocturnaEnabled(index);

                  final fechaDia = _selectedDate!.add(Duration(days: index));
                  final fechaFormateada = DateFormat('dd/MM/yyyy').format(fechaDia);

                  return Card(
                    color: Colors.purple.shade50,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Día ${index + 1}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                          Text("Fecha: $fechaFormateada",
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 8),
                          Text(_getDayStatus(index, todayIndex),
                              style: const TextStyle(fontSize: 14)),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: matutinaEnabled
                                      ? () => _openActivity(activityMatutina, matutinaKey)
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: matutinaEnabled
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text("Sesión Matutina"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: nocturnaEnabled
                                      ? () => _openActivity(activityNocturna, nocturnaKey)
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: nocturnaEnabled
                                        ? Colors.deepPurple
                                        : Colors.grey,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: const Text("Sesión Nocturna"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: _selectedDate != null &&
        _completedSessions.contains("29_nocturna")
    ? FloatingActionButton.extended(
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Evaluacion3MesesPage(),
            ),
          );

          // 🔹 Si la evaluación se completó, guardamos en preferencias
          if (resultado == true) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool('evaluacion_3meses_completada', true);
          }
        },
        label: const Text("Ir a Evaluación"),
        icon: const Icon(Icons.check_circle),
        backgroundColor: Colors.deepPurple,
      )
    : null,
    );
  }
}

