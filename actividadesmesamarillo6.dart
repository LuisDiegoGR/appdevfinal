import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'actividad_motrizmes6.dart';
import 'actividad_neurologicomes6.dart';
import 'actividad_olfato_gusto.dart';
import 'actividad_coordinacion_equilibriomes6.dart';
import 'actividad_vistames6.dart';
import 'actividad_audicionmes6.dart';
import 'verdeevaluacionfinal.dart';
import 'package:intl/intl.dart';

class ActividadesAmarillo6 extends StatefulWidget {
  const ActividadesAmarillo6({super.key});

  @override
  State<ActividadesAmarillo6> createState() => _ActividadesAmarillo6State();
}

class _ActividadesAmarillo6State extends State<ActividadesAmarillo6> {
  DateTime? _selectedDate;
  final Set<String> _completedSessions = {};
  final Map<String, DateTime> _sessionCompletionDates = {};
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String nombreUsuario = '';

  final List<Map<String, dynamic>> _activityBuilders = [
    {'widget': () => ActividadMotrizMes6(), 'nombre': 'Motriz'},
    {'widget': () => ActividadNeurologicoMes6(), 'nombre': 'Neurológico'},
    {'widget': () => ActividadOlfatoGusto(), 'nombre': 'Olfato y Gusto'},
    {'widget': () => ActividadCoordinacionEquilibrioMes6(), 'nombre': 'Coordinación y Equilibrio'},
    {'widget': () => ActividadVistaMes6(), 'nombre': 'Vista'},
    {'widget': () => CuentoAudioPage(), 'nombre': 'Audición'},
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

  void _openActivity(Widget activity, String sessionKey, int index, String sesionTipo, String estimulo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => activity),
    ).then((_) {
      setState(() {
        _completedSessions.add(sessionKey);
        _sessionCompletionDates[sessionKey] = DateTime.now();
      });
      _guardarFirestore(index, sesionTipo, estimulo);
      _saveProgress();
    });
  }

  Future<void> _guardarFirestore(int index, String sesion, String estimulo) async {
    if (_selectedDate == null) return;
    final fechaActividad = _selectedDate!.add(Duration(days: index));
    final hoy = DateTime.now();
    final fechaRealizacion = hoy.toIso8601String();
    final fechaActividadSinHora = DateTime(fechaActividad.year, fechaActividad.month, fechaActividad.day);
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    String estado = (fechaActividadSinHora == hoySinHora) ? 'realizada a tiempo' : 'realizada a destiempo';

    final userId = nombreUsuario.isNotEmpty ? nombreUsuario : _auth.currentUser?.uid ?? 'usuario_demo';
    final progresoRef = _firestore.collection('progreso_mes6_6').doc(userId);

    await progresoRef.set({
      'fecha_inicio': _selectedDate!.toIso8601String(),
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    await progresoRef.collection('actividades').doc('sesion_${sesion}_${index + 1}').set({
      'dia': index + 1,
      'sesion': sesion,
      'estado': estado,
      'estimulo': estimulo,
      'fecha': fechaActividad.toIso8601String(),
      'fecha_realizacion': fechaRealizacion,
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
    return _completedSessions.contains("${dayIndex}_matutina");
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
    prefs.setStringList('amarillo6_sessions', _completedSessions.toList());

    if (_selectedDate != null) {
      prefs.setString('amarillo6_startDate', _selectedDate!.toIso8601String());
    }

    for (var entry in _sessionCompletionDates.entries) {
      prefs.setString('amarillo6_${entry.key}_date', entry.value.toIso8601String());
    }
  }

  Future<void> _loadProgress() async {
    final prefs = await SharedPreferences.getInstance();
    final sessions = prefs.getStringList('amarillo6_sessions') ?? [];
    final dateStr = prefs.getString('amarillo6_startDate');

    setState(() {
      _completedSessions.addAll(sessions);
      if (dateStr != null) {
        _selectedDate = DateTime.tryParse(dateStr);
      }

      for (var key in sessions) {
        final dateKey = prefs.getString('amarillo6_${key}_date');
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

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes 6 - Actividades con Riesgo"),
        backgroundColor: const Color.fromARGB(255, 33, 83, 234),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _selectedDate == null
            ? Center(
                child: ElevatedButton(
                  onPressed: _pickStartDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 213, 93, 250),
                  ),
                  child: const Text("Escoge la fecha de inicio"),
                ),
              )
            : ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  final matutinaKey = "${index}_matutina";
                  final nocturnaKey = "${index}_nocturna";

                  final matutina = _activityBuilders[index % _activityBuilders.length];
                  final nocturna = _activityBuilders[(index + 1) % _activityBuilders.length];

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
                                          matutina['widget'](),
                                          matutinaKey,
                                          index,
                                          'matutina',
                                          matutina['nombre'])
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: matutinaEnabled
                                        ? const Color.fromARGB(255, 130, 83, 177)
                                        : Colors.grey,
                                  ),
                                  child: const Text("Sesión Matutina"),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: nocturnaEnabled
                                      ? () => _openActivity(
                                          nocturna['widget'](),
                                          nocturnaKey,
                                          index,
                                          'nocturna',
                                          nocturna['nombre'])
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: nocturnaEnabled
                                        ? const Color.fromARGB(255, 41, 128, 190)
                                        : Colors.grey,
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VerdeEvaluacionFinalPage(),
                  ),
                );
              },
              label: const Text("Ir a Evaluación"),
              icon: const Icon(Icons.check_circle),
              backgroundColor: Colors.green,
            )
          : null,
    );
  }
}





