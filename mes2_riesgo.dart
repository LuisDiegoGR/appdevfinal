import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'actividad_vistames2.dart';
import 'actividad_tactomes2.dart';
import 'actividad_audicionmes2.dart';
import 'actividad_neurologicomes2.dart';
import 'actividad_olfatomes2.dart';
import 'actividad_Desarrollo_motrizmes2.dart';

class Mes2Riesgo extends StatefulWidget {
  const Mes2Riesgo({super.key});

  @override
  State<Mes2Riesgo> createState() => _Mes2RiesgoState();
}

class _Mes2RiesgoState extends State<Mes2Riesgo> {
  DateTime? startDate;
  List<DateTime> monthDates = [];
  late SharedPreferences prefs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String nombreUsuario = '';

  final List<Map<String, dynamic>> actividades = [
    {'nombre': 'Vista', 'pagina': ActividadVistaMes2()},
    {'nombre': 'Tacto', 'pagina': ActividadTactoMes2()},
    {'nombre': 'Audición', 'pagina': const ActividadAudicionMes2Page()},
    {'nombre': 'Neurológico', 'pagina': ActividadNeurologicoMes2()},
    {'nombre': 'Olfato', 'pagina': const ActividadOlfatoMes2()},
    {'nombre': 'Desarrollo Motriz', 'pagina': const ActividadDesarrolloMotrizMes2()},
  ];

  @override
  void initState() {
    super.initState();
    initPrefs();
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

  Future<void> initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    String? savedDate = prefs.getString('startDate');
    if (savedDate != null) {
      startDate = DateTime.parse(savedDate);
      _generateMonthDates(startDate!);
    }
    setState(() {});
  }

  void _generateMonthDates(DateTime start) {
    monthDates = List.generate(30, (index) => start.add(Duration(days: index)));
  }

  void _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      await prefs.setString('startDate', picked.toIso8601String());
      setState(() {
        startDate = picked;
        _generateMonthDates(picked);
      });
    }
  }

  bool isMatutinaUnlocked(int index) {
    if (index == 0) return true;
    final previousNocturnaDone = prefs.getBool('day_${index - 1}_nocturna_done') ?? false;
    final today = DateTime.now();
    final dayDate = monthDates[index];
    return previousNocturnaDone &&
        !today.isBefore(DateTime(dayDate.year, dayDate.month, dayDate.day));
  }

  bool isNocturnaUnlocked(int index) {
    return prefs.getBool('day_${index}_matutina_done') ?? false;
  }

  void markMatutinaDone(int index) async {
    await prefs.setBool('day_${index}_matutina_done', true);
    await prefs.setString('day_${index}_matutina_date', DateTime.now().toIso8601String());
    await _guardarFirestore(index, 'matutina');
    setState(() {});
  }

  void markNocturnaDone(int index) async {
    await prefs.setBool('day_${index}_nocturna_done', true);
    await prefs.setString('day_${index}_nocturna_date', DateTime.now().toIso8601String());
    await _guardarFirestore(index, 'nocturna');
    setState(() {});
  }

  Future<void> _guardarFirestore(int index, String sesion) async {
    if (startDate == null) return;
    final estimulo = actividades[sesion == 'matutina' ? index % actividades.length : (index + 1) % actividades.length]['nombre'];
    final fechaActividad = monthDates[index];
    final hoy = DateTime.now();
    final fechaRealizacion = hoy.toIso8601String();
    final fechaActividadSinHora = DateTime(fechaActividad.year, fechaActividad.month, fechaActividad.day);
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    String estado = (fechaActividadSinHora == hoySinHora) ? 'realizada a tiempo' : 'realizada a destiempo';

    final userId = nombreUsuario.isNotEmpty ? nombreUsuario : _auth.currentUser?.uid ?? 'usuario_demo';
    final progresoRef = _firestore.collection('progreso_mes2_2').doc(userId);

    await progresoRef.set({
      'fecha_inicio': startDate!.toIso8601String(),
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

  String getIndicador(int index) {
    final doneMatutina = prefs.getBool('day_${index}_matutina_done') ?? false;
    final doneNocturna = prefs.getBool('day_${index}_nocturna_done') ?? false;

    if (!doneMatutina && !doneNocturna) return "❌";
    if (doneMatutina && doneNocturna) {
      final mDateStr = prefs.getString('day_${index}_matutina_date');
      final nDateStr = prefs.getString('day_${index}_nocturna_date');
      if (mDateStr != null && nDateStr != null) {
        final mDate = DateTime.parse(mDateStr);
        final nDate = DateTime.parse(nDateStr);
        if (mDate.year == nDate.year &&
            mDate.month == nDate.month &&
            mDate.day == nDate.day) {
          return "✔️";
        } else {
          return "🚼";
        }
      }
    }
    return "⚠️";
  }

  void _navigateTo(Widget page, VoidCallback onCompleted) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page)).then((_) {
      onCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEDE7F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFF7E57C2),
        title: const Text("Mes 2 - Actividades con Riesgo",
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        elevation: 5,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: startDate == null
            ? Center(
                child: ElevatedButton.icon(
                  onPressed: _pickDate,
                  icon: const Icon(Icons.date_range),
                  label: const Text("Seleccionar fecha de inicio"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9575CD),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                ),
              )
            : ListView.builder(
                itemCount: monthDates.length,
                itemBuilder: (context, index) {
                  final date = monthDates[index];
                  final formattedDate = DateFormat('dd MMM yyyy').format(date);
                  final matutina = actividades[index % actividades.length];
                  final nocturna = actividades[(index + 1) % actividades.length];
                  final matutinaUnlocked = isMatutinaUnlocked(index);
                  final nocturnaUnlocked = isNocturnaUnlocked(index);
                  final emoji = getIndicador(index);

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.deepPurple.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Día ${index + 1} - $formattedDate",
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5E35B1),
                                ),
                              ),
                            ),
                            Text(
                              emoji,
                              style: const TextStyle(fontSize: 26),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text("🌅 Matutina: ${matutina['nombre']}",
                            style: const TextStyle(fontSize: 15)),
                        Text("🌙 Nocturna: ${nocturna['nombre']}",
                            style: const TextStyle(fontSize: 15)),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: matutinaUnlocked
                                  ? () => _navigateTo(matutina['pagina'], () {
                                        markMatutinaDone(index);
                                      })
                                  : null,
                              child: const Text("Ir a Matutina"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFAB47BC),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: nocturnaUnlocked
                                  ? () => _navigateTo(nocturna['pagina'], () {
                                        markNocturnaDone(index);
                                      })
                                  : null,
                              child: const Text("Ir a Nocturna"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF8E24AA),
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}




