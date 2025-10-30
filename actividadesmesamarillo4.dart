import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'actividad_olfatomes4.dart';
import 'actividad_vistames4.dart';
import 'actividad_coordinacion_equilibriomes4.dart';
import 'actividadMes4_DesarrolloMotriz-Neurologicomes4.dart';
import 'actividad_DesarrolloVestíbular_Propioseptivomes4.dart';
import 'package:intl/intl.dart';

class ActividadesAmarillo4 extends StatefulWidget {
  const ActividadesAmarillo4({super.key});

  @override
  State<ActividadesAmarillo4> createState() => _ActividadesAmarillo4State();
}

class _ActividadesAmarillo4State extends State<ActividadesAmarillo4> {
  DateTime? _selectedDate;
  final Set<String> _completedSessions = {};
  final Map<String, DateTime> _sessionCompletionDates = {};

  final List<Widget Function()> _activityBuilders = [
    () => ActividadVistaMes4(),
    () => ActividadCoordinacionEquilibrio(),
    () => ActividadDesarrolloVestibularPropioseptivoMes4(),
    () => ActividadMes4DesarrolloMotrizNeurologico(),
    () => ActividadOlfatoMes4(),
  ];

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String nombreUsuario = '';

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

  Future<void> _pickStartDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _completedSessions.clear();
      });
      await _saveProgress();
    }
  }

  void _openActivity(Widget activity, String sessionKey, String estimulo, int index) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => activity),
    ).then((_) async {
      setState(() {
        _completedSessions.add(sessionKey);
        _sessionCompletionDates[sessionKey] = DateTime.now();
      });
      await _saveProgress();
      await _saveToFirestore(sessionKey, estimulo, index);
    });
  }

  Future<void> _saveToFirestore(String sessionKey, String estimulo, int index) async {
    if (_selectedDate == null) return;
    final fechaActividad = _selectedDate!.add(Duration(days: index));
    final fechaRealizacion = _sessionCompletionDates[sessionKey];
    String estado = "pendiente";

    if (fechaRealizacion != null) {
      if (DateUtils.isSameDay(fechaActividad, fechaRealizacion)) {
        estado = "realizada a tiempo";
      } else {
        estado = "realizada a destiempo";
      }
    } else if (fechaActividad.isBefore(DateTime.now())) {
      estado = "no completada";
    }

    final progresoRef = _firestore.collection('progreso_mes4_4').doc(nombreUsuario);
    await progresoRef.set({
      'fecha_inicio': _selectedDate!.toIso8601String(),
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await progresoRef.collection('actividades').doc(sessionKey).set({
      'dia': index + 1,
      'sesion': sessionKey.contains('matutina') ? 'matutina' : 'nocturna',
      'estado': estado,
      'estimulo': estimulo,
      'fecha': fechaActividad.toIso8601String(),
      'fecha_realizacion': fechaRealizacion?.toIso8601String() ?? '',
      'usuario': nombreUsuario,
    }, SetOptions(merge: true));
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

    final matutinaDate = _sessionCompletionDates[matutinaKey];
    final nocturnaDate = _sessionCompletionDates[nocturnaKey];
    final expectedDate = _selectedDate!.add(Duration(days: index));

    bool isOnTime(DateTime? actualDate) {
      if (actualDate == null) return false;
      return DateUtils.isSameDay(actualDate, expectedDate);
    }

    if (matutinaDone && nocturnaDone) {
      if (!isOnTime(matutinaDate) || !isOnTime(nocturnaDate)) {
        return "Estado: Completado a destiempo 👀";
      }
      return "Estado: Completado 🤩";
    } else if (matutinaDone || nocturnaDone) {
      if (index < todayIndex) return "Estado: Casi completado 🤨";
      if (index == todayIndex) return "Estado: Incompleto hoy 😅";
      return "Estado: Realizado a destiempo ☹";
    } else {
      if (index < todayIndex) return "Estado: No realizado 😭";
      return "Estado: —";
    }
  }

  Future<void> _saveProgress() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('amarillo4_sessions', _completedSessions.toList());

    if (_selectedDate != null) {
      prefs.setString('amarillo4_startDate', _selectedDate!.toIso8601String());
    }

    for (var entry in _sessionCompletionDates.entries) {
      prefs.setString('amarillo4_${entry.key}_date', entry.value.toIso8601String());
    }
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getStringList('amarillo4_sessions') ?? [];
    final dateStr = prefs.getString('amarillo4_startDate');

    setState(() {
      _completedSessions.addAll(sessions);
      if (dateStr != null) {
        _selectedDate = DateTime.tryParse(dateStr);
      }

      for (var key in sessions) {
        final dateKey = prefs.getString('amarillo4_${key}_date');
        if (dateKey != null) {
          final date = DateTime.tryParse(dateKey);
          if (date != null) {
            _sessionCompletionDates[key] = date;
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int todayIndex = 0;
    if (_selectedDate != null) {
      todayIndex = DateTime.now().difference(_selectedDate!).inDays;
      todayIndex = todayIndex.clamp(0, 29);
    }

    List<String> nombresEstimulos = [
      "vista",
      "coordinación y equilibrio",
      "vestibular y propioceptivo",
      "motriz y neurológico",
      "olfato",
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes 4 - Actividades con Riesgo"),
        backgroundColor: Colors.orangeAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _selectedDate == null
            ? Center(
                child: ElevatedButton(
                  onPressed: _pickStartDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: const Text("Escoge la fecha de inicio"),
                ),
              )
            : ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  final matutinaKey = "${index}_matutina";
                  final nocturnaKey = "${index}_nocturna";

                  final actividadMatutina =
                      _activityBuilders[index % _activityBuilders.length]();
                  final actividadNocturna =
                      _activityBuilders[(index + 1) % _activityBuilders.length]();

                  final estimuloMat = nombresEstimulos[index % nombresEstimulos.length];
                  final estimuloNoc = nombresEstimulos[(index + 1) % nombresEstimulos.length];

                  final matutinaEnabled = _isMatutinaEnabled(index, todayIndex);
                  final nocturnaEnabled = _isNocturnaEnabled(index);

                  final fechaDia = _selectedDate!.add(Duration(days: index));
                  final fechaFormateada = DateFormat('dd/MM/yyyy').format(fechaDia);

                  return Card(
                    color: Colors.yellow.shade50,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Día ${index + 1}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16)),
                          Text("Fecha: $fechaFormateada",
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              )),
                          const SizedBox(height: 8),
                          Text(
                            _getDayStatus(index, todayIndex),
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: matutinaEnabled
                                      ? () => _openActivity(
                                          actividadMatutina, matutinaKey, estimuloMat, index)
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        matutinaEnabled ? Colors.orange : Colors.grey,
                                  ),
                                  child: const Text("Sesión Matutina"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: nocturnaEnabled
                                      ? () => _openActivity(
                                          actividadNocturna, nocturnaKey, estimuloNoc, index)
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        nocturnaEnabled ? Colors.orange : Colors.grey,
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
    );
  }
}

