// Código equivalente adaptado para Mes 5 con Firestore siguiendo la lógica de Mes 2

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'actividad_Coordinacion_Equilibrio_mes5.dart';
import 'actividad_Motrizmes5.dart';
import 'actividad_vistames5.dart';
import 'actividad_neurologicomes5.dart';
import 'actividad_audicionmes5.dart';
import 'actividad_olfatomes5.dart';

class Mes5Riesgo extends StatefulWidget {
  const Mes5Riesgo({super.key});

  @override
  State<Mes5Riesgo> createState() => _Mes5RiesgoState();
}

class _Mes5RiesgoState extends State<Mes5Riesgo> {
  DateTime? startDate;
  List<DateTime> monthDates = [];
  late SharedPreferences prefs;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String nombreUsuario = '';

  final List<Map<String, dynamic>> actividades = [
    {'nombre': 'Motriz', 'pagina': ActividadMotrizMes5()},
    {'nombre': 'Neurológico', 'pagina': ActividadNeurologicoMes5()},
    {'nombre': 'Olfato', 'pagina': ActividadOlfatoMes5()},
    {'nombre': 'Coordinación y Equilibrio', 'pagina': ActividadCoordinacionEquilibrioMes5()},
    {'nombre': 'Vista', 'pagina': ActividadVistaMes5()},
    {'nombre': 'Audición', 'pagina': ActividadAudicionMes5()},
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
    String? savedDate = prefs.getString('startDate_mes5');
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
      await prefs.setString('startDate_mes5', picked.toIso8601String());
      setState(() {
        startDate = picked;
        _generateMonthDates(picked);
      });
    }
  }

  bool isMatutinaUnlocked(int index) {
    if (index == 0) return true;
    final previousNocturnaDone = prefs.getBool('mes5_day_${index - 1}_nocturna_done') ?? false;
    final today = DateTime.now();
    final dayDate = monthDates[index];
    return previousNocturnaDone &&
        !today.isBefore(DateTime(dayDate.year, dayDate.month, dayDate.day));
  }

  bool isNocturnaUnlocked(int index) {
    return prefs.getBool('mes5_day_${index}_matutina_done') ?? false;
  }

  void markMatutinaDone(int index) async {
    await prefs.setBool('mes5_day_${index}_matutina_done', true);
    await prefs.setString('mes5_day_${index}_matutina_date', DateTime.now().toIso8601String());
    await _guardarFirestore(index, 'matutina');
    setState(() {});
  }

  void markNocturnaDone(int index) async {
    await prefs.setBool('mes5_day_${index}_nocturna_done', true);
    await prefs.setString('mes5_day_${index}_nocturna_date', DateTime.now().toIso8601String());
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
    final progresoRef = _firestore.collection('progreso_mes5_5').doc(userId);

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

  void _navigateTo(Widget page, VoidCallback onCompleted) {
    Navigator.push(context, MaterialPageRoute(builder: (_) => page)).then((_) {
      onCompleted();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFDE7),
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: const Text("Mes 5 - Actividades con Riesgo"),
        centerTitle: true,
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
                    backgroundColor: Colors.orange,
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

                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Día ${index + 1} - $formattedDate",
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepOrange,
                            )),
                        const SizedBox(height: 10),
                        Text("🌅 Matutina: ${matutina['nombre']}"),
                        Text("🌙 Nocturna: ${nocturna['nombre']}"),
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
                                backgroundColor: Colors.deepOrange,
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
                                backgroundColor: Colors.orangeAccent,
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






