import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'actividad_motrizmes6.dart';
import 'actividad_neurologicomes6.dart';
import 'actividad_olfato_gusto.dart';
import 'actividad_coordinacion_equilibriomes6.dart';
import 'actividad_vistames6.dart';
import 'actividad_audicionmes6.dart';
import 'verdeevaluacionfinal.dart';

class ActividadesMesVerde6 extends StatefulWidget {
  @override
  _Mes6PageState createState() => _Mes6PageState();
}

class _Mes6PageState extends State<ActividadesMesVerde6> {
  DateTime? _selectedDate;
  DateTime _focusedDate = DateTime.now();
  Map<DateTime, Widget> activities = {};
  Map<DateTime, bool> activityCompleted = {};
  Map<DateTime, bool> activityEntered = {};
  Map<DateTime, DateTime> activityCompletionDate = {};
  bool showCalendar = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  final Map<String, String> activityLabels = {
    'ActividadMotrizMes6': 'Motriz',
    'ActividadNeurologicoMes6': 'Neurologico',
    'ActividadOlfatoGusto': 'Olfato_Gusto',
    'ActividadCoordinacionEquilibrioMes6': 'Coordinacion_Equilibrio',
    'ActividadVistaMes6': 'Vista',
    'CuentoAudioPage': 'Audicion',
  };

  @override
  void initState() {
    super.initState();
    _loadProgress();
  }

  void _generateActivities(DateTime startDate) {
    activities.clear();
    activityCompleted.clear();
    activityEntered.clear();
    activityCompletionDate.clear();

    List<Widget> activityPages = [
      ActividadMotrizMes6(),
      ActividadNeurologicoMes6(),
      ActividadOlfatoGusto(),
      ActividadCoordinacionEquilibrioMes6(),
      ActividadVistaMes6(),
      CuentoAudioPage(),
    ];

    for (int i = 0; i < 30; i++) {
      DateTime date = DateTime(startDate.year, startDate.month, startDate.day + i);
      Widget page = activityPages[i % activityPages.length];
      activities[date] = page;
      activityCompleted[date] = false;
      activityEntered[date] = false;
    }

    _saveProgress();
    setState(() {
      showCalendar = true;
      _focusedDate = startDate;
    });
  }

  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, bool> completedMap =
        activityCompleted.map((key, value) => MapEntry(key.toIso8601String(), value));
    Map<String, bool> enteredMap =
        activityEntered.map((key, value) => MapEntry(key.toIso8601String(), value));
    Map<String, String> completionDateMap = activityCompletionDate.map(
      (key, value) => MapEntry(key.toIso8601String(), value.toIso8601String()),
    );

    await prefs.setString('selectedDateMes6', _selectedDate?.toIso8601String() ?? '');
    await prefs.setString('completedMes6', json.encode(completedMap));
    await prefs.setString('enteredMes6', json.encode(enteredMap));
    await prefs.setString('completionDatesMes6', json.encode(completionDateMap));

    await _saveProgressToFirebase();
  }

  Future<void> _saveProgressToFirebase() async {
    final user = _auth.currentUser;
    if (user == null) return;

    // Obtener el nombre completo desde la colección users
    DocumentSnapshot userDoc =
        await _firestore.collection('users').doc(user.uid).get();

    String nombre = userDoc.get('name') ?? 'Desconocido';
    String apellido = userDoc.get('lastName') ?? '';
    String nombreCompleto = '$nombre $apellido';

    // Guardar en la colección programa_mes6_verde con nombre como ID
    final progresoRef = _firestore
        .collection('programa_mes6_verde')
        .doc(nombreCompleto); // <- Aquí se usa como ID

    await progresoRef.set({
      'fecha_inicio': _selectedDate?.toIso8601String() ?? '',
      'nombre_usuario': nombreCompleto,
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    });

    int sesionNum = 1;
    for (final entry in activities.entries) {
      final date = entry.key;
      final actividadDoc = progresoRef.collection('actividades').doc('sesion$sesionNum');

      String className = entry.value.runtimeType.toString();
      String nombreActividad = activityLabels[className] ?? 'actividad';

      final realizadoTexto = activityCompleted[date] == true ? 'realizado - $nombreActividad' : '';
      final entroTexto = activityEntered[date] == true ? 'realizado - $nombreActividad' : '';
      final fechaCompletado = activityCompletionDate[date]?.toIso8601String() ?? '';

      final estado = _calcularEstado(date);

      await actividadDoc.set({
        'fecha_sesion': date.toIso8601String(),
        'completado': realizadoTexto,
        'entro': entroTexto,
        'fecha_completado': fechaCompletado,
        'estado': estado,
      }, SetOptions(merge: true));

      sesionNum++;
    }
  }

  String _calcularEstado(DateTime fechaSesion) {
    final hoy = DateTime.now();
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    final fechaSesionSinHora = DateTime(fechaSesion.year, fechaSesion.month, fechaSesion.day);
    final completado = activityCompleted[fechaSesion] ?? false;
    final fechaCompletado = activityCompletionDate[fechaSesion];

    if (completado && fechaCompletado != null) {
      if (isSameDay(fechaCompletado, fechaSesion)) {
        return "Hecho a tiempo";
      } else {
        return "Hecho a destiempo";
      }
    } else if (fechaSesionSinHora.isBefore(hoySinHora)) {
      return "No completado";
    } else {
      return "Pendiente";
    }
  }

  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDateStr = prefs.getString('selectedDateMes6');

    if (selectedDateStr != null && selectedDateStr.isNotEmpty) {
      _selectedDate = DateTime.parse(selectedDateStr);
      Map<String, dynamic> completedMap = json.decode(prefs.getString('completedMes6') ?? '{}');
      Map<String, dynamic> enteredMap = json.decode(prefs.getString('enteredMes6') ?? '{}');
      Map<String, dynamic> completionDatesMap =
          json.decode(prefs.getString('completionDatesMes6') ?? '{}');

      _generateActivities(_selectedDate!);

      activityCompleted = completedMap.map((key, value) => MapEntry(DateTime.parse(key), value));
      activityEntered = enteredMap.map((key, value) => MapEntry(DateTime.parse(key), value));
      activityCompletionDate = completionDatesMap.map(
          (key, value) => MapEntry(DateTime.parse(key), DateTime.parse(value)));

      setState(() {
        showCalendar = true;
      });
    }
  }

  void _completeActivity(DateTime date) {
    final today = DateTime.now();
    final todayOnly = DateTime(today.year, today.month, today.day);
    setState(() {
      activityCompleted[date] = true;
      activityEntered[date] = true;
      activityCompletionDate[date] = todayOnly;
    });

    _saveProgress();
  }

  void _selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      _selectedDate = picked;
      _generateActivities(picked);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Fecha de inicio guardada para Mes 6!'),
          backgroundColor: Colors.green.shade400,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F8F6),
      appBar: AppBar(
        title: Text("Actividades - Mes 6"),
        backgroundColor: Colors.green.shade700,
        centerTitle: true,
      ),
      body: Column(
        children: [
          if (!showCalendar)
            Padding(
              padding: const EdgeInsets.all(20),
              child: AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                title: Text("Selecciona fecha de inicio"),
                content: Text("Elige el día para comenzar el Mes 6."),
                actions: [
                  TextButton(
                    onPressed: _selectDate,
                    child: Text("Elegir fecha"),
                  ),
                ],
              ),
            ),
          if (showCalendar)
            Expanded(
              child: Column(
                children: [
                  TableCalendar(
                    firstDay: DateTime.utc(2020),
                    lastDay: DateTime.utc(2100),
                    focusedDay: _focusedDate,
                    selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                    onDaySelected: (selected, focused) {
                      if (selected.isAfter(DateTime.now())) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Fecha no válida"),
                            content: Text("No puedes seleccionar fechas futuras."),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("OK"),
                              ),
                            ],
                          ),
                        );
                      } else {
                        setState(() {
                          _selectedDate = selected;
                          _focusedDate = focused;
                        });
                      }
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(
                          color: Colors.green.shade400, shape: BoxShape.circle),
                      selectedDecoration:
                          BoxDecoration(color: Colors.green.shade800, shape: BoxShape.circle),
                      markerDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                      weekendTextStyle: TextStyle(color: Colors.redAccent),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      decoration: BoxDecoration(color: Colors.green.shade100),
                      titleTextStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        final dayOnly = DateTime(day.year, day.month, day.day);
                        if (activities.containsKey(dayOnly)) {
                          final today = DateTime.now();
                          final todayOnly = DateTime(today.year, today.month, today.day);

                          if (activityCompleted[dayOnly] == true) {
                            final completedOn = activityCompletionDate[dayOnly];

                            if (completedOn != null) {
                              if (isSameDay(completedOn, dayOnly)) {
                                return Center(child: Text("✅"));
                              } else if (completedOn.isAfter(dayOnly)) {
                                return Center(child: Text("⏰"));
                              }
                            }
                          } else if (dayOnly.isBefore(todayOnly)) {
                            return Center(child: Text("❌"));
                          } else {
                            return Center(child: Text("👩🏼‍🍼"));
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final entry = activities.entries.elementAt(index);
                        final date = entry.key;
                        final page = entry.value;
                        final today = DateTime.now();
                        final cleanToday = DateTime(today.year, today.month, today.day);
                        final isAvailable = date.isBefore(cleanToday) ||
                            date.isAtSameMomentAs(cleanToday) ||
                            date.isAtSameMomentAs(_selectedDate!);

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: Icon(Icons.child_friendly, color: Colors.green.shade700),
                            title: Text(
                              "Sesión del ${date.day}/${date.month}/${date.year}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            trailing: ElevatedButton(
                              onPressed: isAvailable
                                  ? () {
                                      if (!activityEntered[date]!) {
                                        _completeActivity(date);
                                      }
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => page),
                                      );
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAvailable ? Colors.green : Colors.grey,
                              ),
                              child: Text("Ir"),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ElevatedButton.icon(
                      onPressed: activityCompleted.values.every((completed) => completed)
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => VerdeEvaluacionFinalPage()),
                              );
                            }
                          : null,
                      icon: Icon(Icons.check_circle),
                      label: Text("Ir a Evaluación"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            activityCompleted.values.every((v) => v) ? Colors.teal : Colors.grey,
                        minimumSize: Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}





