import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'actividad_vistames1.dart';
import 'actividad_olfatomes1.dart';
import 'actividad_motrizmes1.dart';
import 'actividad_Desarrollo_vestibularmes1.dart';
import 'actividad_Neorologicames1.dart';
import 'actividad_audicionmes1.dart';

class Mes1Riesgo extends StatefulWidget {
  const Mes1Riesgo({super.key});

  @override
  State<Mes1Riesgo> createState() => _Mes1RiesgoState();
}

class _Mes1RiesgoState extends State<Mes1Riesgo> {
  DateTime? _selectedDate;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String nombreUsuario = '';

  final List<Widget Function()> sesiones = [
    () => EstimVistaMes1(),
    () => const ActividadOlfatoMes1(),
    () => ActividadMotrizMes1(),
    () => JuegoPage(),
    () => Video3Page(),
    () => const ActividadAudicionMes1()
  ];

  final Map<DateTime, Widget> activities = {};
  // Eliminamos activityCompleted y activityCompletionDate para no duplicar datos
  // Usaremos los sets y mapas para estados y fechas:
  final Set<int> matutinaCompletada = {};
  final Set<int> nocturnaCompletada = {};
  final Map<int, DateTime> diaCompletadoMatutina = {};
  final Map<int, DateTime> diaCompletadoNocturna = {};
  final Map<DateTime, String> nombreSesionPorFecha = {};

  @override
  void initState() {
    super.initState();
    _cargarNombreUsuario();
    _cargarProgreso();
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


  Future<void> _guardarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    if (_selectedDate != null) {
      await prefs.setString('fechaInicio', _selectedDate!.toIso8601String());
    }
    await prefs.setStringList(
        'matutina', matutinaCompletada.map((e) => e.toString()).toList());
    await prefs.setStringList(
        'nocturna', nocturnaCompletada.map((e) => e.toString()).toList());

    await prefs.setString(
        'matutinaFechas',
        jsonEncode(diaCompletadoMatutina
            .map((key, value) => MapEntry(key.toString(), value.toIso8601String()))));

    await prefs.setString(
        'nocturnaFechas',
        jsonEncode(diaCompletadoNocturna
            .map((key, value) => MapEntry(key.toString(), value.toIso8601String()))));

    await _saveProgressToFirebase();
  }

  Future<void> _cargarProgreso() async {
    final prefs = await SharedPreferences.getInstance();
    final fecha = prefs.getString('fechaInicio');
    if (fecha != null) {
      _selectedDate = DateTime.tryParse(fecha);
      if (_selectedDate != null) {
        _generateActivities(_selectedDate!);
      }
    }

    matutinaCompletada.addAll(prefs.getStringList('matutina')?.map(int.parse) ?? []);
    nocturnaCompletada.addAll(prefs.getStringList('nocturna')?.map(int.parse) ?? []);

    final matFechasStr = prefs.getString('matutinaFechas');
    if (matFechasStr != null) {
      final Map<String, dynamic> parsed = jsonDecode(matFechasStr);
      diaCompletadoMatutina
          .addAll(parsed.map((k, v) => MapEntry(int.parse(k), DateTime.parse(v))));
    }

    final nocFechasStr = prefs.getString('nocturnaFechas');
    if (nocFechasStr != null) {
      final Map<String, dynamic> parsed = jsonDecode(nocFechasStr);
      diaCompletadoNocturna
          .addAll(parsed.map((k, v) => MapEntry(int.parse(k), DateTime.parse(v))));
    }

    setState(() {});
  }

  void _generateActivities(DateTime startDate) {
    activities.clear();
    nombreSesionPorFecha.clear();

    List<Widget> activityPages = [
      EstimVistaMes1(),
      ActividadOlfatoMes1(),
      ActividadMotrizMes1(),
      JuegoPage(),
      Video3Page(),
      ActividadAudicionMes1(),
    ];

    List<String> nombresSesiones = [
      'Vista',
      'Olfato',
      'Motricidad',
      'Juego',
      'Video',
      'Audición',
    ];

    for (int i = 0; i < 30; i++) {
      DateTime activityDate = startDate.add(Duration(days: i));
      DateTime simpleDate = DateTime(activityDate.year, activityDate.month, activityDate.day);
      Widget page = activityPages[i % activityPages.length];
      String nombreSesion = nombresSesiones[i % nombresSesiones.length];
      activities[simpleDate] = page;
      nombreSesionPorFecha[simpleDate] = nombreSesion;
    }

    setState(() {});
  }

  String calcularEstado(int index, bool esMatutina) {
    if (_selectedDate == null) return "pendiente";

    DateTime fechaActividad = _selectedDate!.add(Duration(days: index));
    DateTime hoy = DateTime.now();
    DateTime hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    DateTime fechaActividadSinHora =
        DateTime(fechaActividad.year, fechaActividad.month, fechaActividad.day);

    bool completada = esMatutina
        ? matutinaCompletada.contains(index)
        : nocturnaCompletada.contains(index);

    DateTime? fechaRealizacion = esMatutina
        ? diaCompletadoMatutina[index]
        : diaCompletadoNocturna[index];

    if (completada && fechaRealizacion != null) {
      DateTime fechaRealSinHora = DateTime(
          fechaRealizacion.year, fechaRealizacion.month, fechaRealizacion.day);
      if (fechaRealSinHora == fechaActividadSinHora) {
        return "realizada a tiempo";
      } else {
        return "realizada a destiempo";
      }
    } else if (fechaActividadSinHora.isBefore(hoySinHora)) {
      return "no completada";
    } else {
      return "pendiente";
    }
  }

  Future<void> _saveProgressToFirebase() async {
    if (_selectedDate == null) return;

    final userId = nombreUsuario.isNotEmpty
        ? nombreUsuario
        : _auth.currentUser?.uid ?? 'usuario_demo';

    final progresoRef = _firestore.collection('progreso_mes1_1').doc(userId);

    // Guardar fecha de inicio y última actualización
    await progresoRef.set({
      'fecha_inicio': _selectedDate!.toIso8601String(),
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    for (int i = 0; i < 30; i++) {
      DateTime fechaDia = _selectedDate!.add(Duration(days: i));
      DateTime soloFecha = DateTime(fechaDia.year, fechaDia.month, fechaDia.day);
      String estimulo = nombreSesionPorFecha[soloFecha] ?? 'desconocido';

      // Matutina
      bool matCompletada = matutinaCompletada.contains(i);
      DateTime? fechaRealMatutina = diaCompletadoMatutina[i];
      String estadoMat = "pendiente";
      if (matCompletada && fechaRealMatutina != null) {
        DateTime fechaRealSinHora = DateTime(
            fechaRealMatutina.year, fechaRealMatutina.month, fechaRealMatutina.day);
        estadoMat = (fechaRealSinHora == soloFecha)
            ? "realizada a tiempo"
            : "realizada a destiempo";
      } else if (soloFecha.isBefore(DateTime.now())) {
        estadoMat = "no completada";
      }

      await progresoRef.collection('actividades').doc('sesion_matutina_${i + 1}').set({
        'dia': i + 1,
        'sesion': 'matutina',
        'estado': estadoMat,
        'estimulo': estimulo,
        'fecha': soloFecha.toIso8601String(),
        'fecha_realizacion': fechaRealMatutina?.toIso8601String() ?? '',
        'usuario': nombreUsuario,
      }, SetOptions(merge: true));

      // Nocturna
      bool nocCompletada = nocturnaCompletada.contains(i);
      DateTime? fechaRealNocturna = diaCompletadoNocturna[i];
      String estadoNoc = "pendiente";
      if (nocCompletada && fechaRealNocturna != null) {
        DateTime fechaRealSinHora = DateTime(
            fechaRealNocturna.year, fechaRealNocturna.month, fechaRealNocturna.day);
        estadoNoc = (fechaRealSinHora == soloFecha)
            ? "realizada a tiempo"
            : "realizada a destiempo";
      } else if (soloFecha.isBefore(DateTime.now())) {
        estadoNoc = "no completada";
      }

      await progresoRef.collection('actividades').doc('sesion_nocturna_${i + 1}').set({
        'dia': i + 1,
        'sesion': 'nocturna',
        'estado': estadoNoc,
        'estimulo': estimulo,
        'fecha': soloFecha.toIso8601String(),
        'fecha_realizacion': fechaRealNocturna?.toIso8601String() ?? '',
        'usuario': nombreUsuario,
      }, SetOptions(merge: true));
    }
  }

  bool estaDesbloqueadoMatutina(DateTime inicio, int dia) {
    final hoy = DateTime.now();
    final fechaDia = DateTime(inicio.year, inicio.month, inicio.day).add(Duration(days: dia));
    return !hoy.isBefore(fechaDia);
  }

  Color obtenerColorModulo(int index) {
    final moduloIndex = index % sesiones.length;
    switch (moduloIndex) {
      case 0:
        return const Color(0xFFFFF9B0);
      case 1:
        return const Color(0xFFFFD3B6);
      case 2:
        return const Color(0xFFA8E6CF);
      case 3:
        return const Color(0xFFB2EBF2);
      case 4:
        return const Color(0xFFE1BEE7);
      case 5:
        return const Color(0xFFDCEDC1);
      default:
        return const Color(0xFFD3D3D3);
    }
  }

  String obtenerEmojiProgreso(int index, DateTime fechaDelDia) {
    final hoy = DateTime.now();
    final bool mat = matutinaCompletada.contains(index);
    final bool noc = nocturnaCompletada.contains(index);
    final bool diaYaPaso = hoy.isAfter(fechaDelDia);

    if (!mat && !noc && diaYaPaso) return '🌑';
    if (mat && noc) {
      if (diaCompletadoMatutina[index]?.day == diaCompletadoNocturna[index]?.day &&
          diaCompletadoMatutina[index]?.month == diaCompletadoNocturna[index]?.month &&
          diaCompletadoMatutina[index]?.year == diaCompletadoNocturna[index]?.year &&
          diaCompletadoMatutina[index]?.day == fechaDelDia.day) {
        return '🌝';
      } else {
        return '🌜';
      }
    }
    if ((mat || noc) && diaYaPaso) return '🌚';
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0FF),
      appBar: AppBar(
        title: const Text("Mes 1 - Actividades con Riesgo"),
        backgroundColor: const Color(0xFFBFA2DB),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.calendar_month),
              label: const Text("Seleccionar fecha de inicio"),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFBFA2DB),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
              onPressed: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (picked != null) {
                  setState(() {
                    _selectedDate = picked;
                    matutinaCompletada.clear();
                    nocturnaCompletada.clear();
                    diaCompletadoMatutina.clear();
                    diaCompletadoNocturna.clear();
                    _generateActivities(picked);
                  });
                  await _guardarProgreso();
                }
              },
            ),
            const SizedBox(height: 16),
            _selectedDate != null
                ? Expanded(
                    child: ListView.builder(
                      itemCount: 30,
                      itemBuilder: (context, index) {
                        final fechaDia = _selectedDate!.add(Duration(days: index));
                        final morningIndex = index % sesiones.length;
                        final nightIndex = (index + 1) % sesiones.length;

                        final bool matutinaDesbloqueada =
                            estaDesbloqueadoMatutina(_selectedDate!, index);
                        final bool nocturnaDesbloqueada = matutinaCompletada.contains(index);
                        final emoji = obtenerEmojiProgreso(index, fechaDia);
                        final colorTarjeta =
                            obtenerColorModulo(morningIndex).withOpacity(0.3);

                        return Container(
                          margin:
                              const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                          decoration: BoxDecoration(
                            color: colorTarjeta,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: obtenerColorModulo(morningIndex).withOpacity(0.5),
                                offset: const Offset(2, 4),
                                blurRadius: 6,
                              )
                            ],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "🗓 Día ${index + 1}",
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                    Text(emoji, style: const TextStyle(fontSize: 26)),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "📆 ${fechaDia.day}/${fechaDia.month}/${fechaDia.year}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black54,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: matutinaDesbloqueada
                                          ? () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        sesiones[morningIndex]()),
                                              ).then((_) async {
                                                setState(() {
                                                  matutinaCompletada.add(index);
                                                  final now = DateTime.now();
                                                  diaCompletadoMatutina[index] = now;
                                                });
                                                await _guardarProgreso();
                                              });
                                            }
                                          : () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Esta actividad se desbloqueará pronto"),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                      icon: const Icon(Icons.wb_sunny_outlined),
                                      label: const Text("Matutina"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: matutinaDesbloqueada
                                            ? obtenerColorModulo(morningIndex)
                                                .withOpacity(0.85)
                                            : Colors.grey.shade400,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: nocturnaDesbloqueada
                                          ? () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        sesiones[nightIndex]()),
                                              ).then((_) async {
                                                setState(() {
                                                  nocturnaCompletada.add(index);
                                                  final now = DateTime.now();
                                                  diaCompletadoNocturna[index] = now;
                                                });
                                                await _guardarProgreso();
                                              });
                                            }
                                          : () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      "Esta actividad se desbloqueará pronto"),
                                                  duration: Duration(seconds: 2),
                                                ),
                                              );
                                            },
                                      icon: const Icon(Icons.nights_stay_outlined),
                                      label: const Text("Nocturna"),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: nocturnaDesbloqueada
                                            ? obtenerColorModulo(nightIndex)
                                                .withOpacity(0.85)
                                            : Colors.grey.shade400,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 24, vertical: 12),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        textStyle: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  "Estado Matutina: ${calcularEstado(index, true)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Text(
                                  "Estado Nocturna: ${calcularEstado(index, false)}",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  )
                : const Text(
                    "Selecciona una fecha de inicio para comenzar.",
                    style: TextStyle(fontSize: 18),
                  ),
          ],
        ),
      ),
    );
  }
}

