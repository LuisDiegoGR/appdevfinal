import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'actividad_Coordinacion_Equilibrio_mes5.dart';
import 'actividad_Motrizmes5.dart';
import 'actividad_vistames5.dart';
import 'actividad_neurologicomes5.dart';
import 'actividad_audicionmes5.dart';
import 'actividad_olfatomes5.dart';
import 'verdeevaluacion5.dart';

class ActividadesMesVerde5 extends StatefulWidget {
  @override
  _Mes5PageState createState() => _Mes5PageState();
}

class _Mes5PageState extends State<ActividadesMesVerde5> {
  DateTime? _selectedDate;
  DateTime _focusedDate = DateTime.now();
  Map<DateTime, Widget> activities = {};
  Map<DateTime, bool> activityCompleted = {};
  Map<DateTime, bool> activityEntered = {};
  Map<DateTime, DateTime> activityCompletionDate = {};
  bool showCalendar = false;

  String? nombreUsuario;
  String? apellidoUsuario;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final Map<String, String> activityLabels = {
    'ActividadCoordinacionEquilibrioMes5': 'Coordinacion_Equilibrio',
    'ActividadMotrizMes5': 'Motriz',
    'ActividadVistaMes5': 'vista',
    'ActividadNeurologicoMes5': 'neurologico',
    'ActividadAudicionMes5': 'audicion',
    'ActividadOlfatoMes5': 'olfato',
  };

  @override
  void initState() {
    super.initState();
    _cargarNombreUsuario();
    _loadProgress();
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

  void _generateActivities(DateTime startDate) {
    activities.clear();
    activityCompleted.clear();
    activityEntered.clear();

    List<Widget> activityPages = [
      ActividadCoordinacionEquilibrioMes5(),
      ActividadMotrizMes5(),
      ActividadVistaMes5(),
      ActividadNeurologicoMes5(),
      ActividadAudicionMes5(),
      ActividadOlfatoMes5(),
    ];

    for (int i = 0; i < 30; i++) {
      DateTime date = startDate.add(Duration(days: i));
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
    Map<String, bool> completedMap = activityCompleted.map((k, v) => MapEntry(k.toIso8601String(), v));
    Map<String, bool> enteredMap = activityEntered.map((k, v) => MapEntry(k.toIso8601String(), v));
    Map<String, String> completionDateMap = activityCompletionDate.map((k, v) => MapEntry(k.toIso8601String(), v.toIso8601String()));

    await prefs.setString('selectedDateMes5', _selectedDate?.toIso8601String() ?? '');
    await prefs.setString('completedMes5', json.encode(completedMap));
    await prefs.setString('enteredMes5', json.encode(enteredMap));
    await prefs.setString('completionDatesMes5', json.encode(completionDateMap));

    await _saveProgressToFirebase();
  }

  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDateStr = prefs.getString('selectedDateMes5');

    if (selectedDateStr != null && selectedDateStr.isNotEmpty) {
      _selectedDate = DateTime.parse(selectedDateStr);
      Map<String, dynamic> completedMap = json.decode(prefs.getString('completedMes5') ?? '{}');
      Map<String, dynamic> enteredMap = json.decode(prefs.getString('enteredMes5') ?? '{}');
      Map<String, dynamic> completionDatesMap = json.decode(prefs.getString('completionDatesMes5') ?? '{}');

      _generateActivities(_selectedDate!);

      activityCompleted = completedMap.map((k, v) => MapEntry(DateTime.parse(k), v));
      activityEntered = enteredMap.map((k, v) => MapEntry(DateTime.parse(k), v));
      activityCompletionDate = completionDatesMap.map((k, v) => MapEntry(DateTime.parse(k), DateTime.parse(v)));

      setState(() => showCalendar = true);
    }
  }

  Future<void> _saveProgressToFirebase() async {
    final user = _auth.currentUser;
    if (user == null || nombreUsuario == null || apellidoUsuario == null) return;

    final docId = '${nombreUsuario}_$apellidoUsuario';
    final progresoRef = _firestore.collection('progreso_mes5_verde').doc(docId);

    await progresoRef.set({
      'fecha_inicio': _selectedDate?.toIso8601String() ?? '',
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    int sesionNum = 1;
    for (final entry in activities.entries) {
      final date = entry.key;
      final page = entry.value;

      final nombreSesion = activityLabels[page.runtimeType.toString()] ?? 'actividad';
      final realizadoTexto = activityCompleted[date] == true ? 'realizado - $nombreSesion' : '';
      final entroTexto = activityEntered[date] == true ? 'realizado - $nombreSesion' : '';
      final fechaCompletado = activityCompletionDate[date]?.toIso8601String();
      final estado = _calcularEstado(date);

      await progresoRef.collection('actividades').doc('sesion$sesionNum').set({
        'fecha_sesion': date.toIso8601String(),
        'completado': realizadoTexto,
        'entro': entroTexto,
        'fecha_completado': fechaCompletado ?? '',
        'estado': estado,
      }, SetOptions(merge: true));
      sesionNum++;
    }
  }

  void _completeActivity(DateTime date, Widget page) {
    final today = DateTime.now();
    final cleanToday = DateTime(today.year, today.month, today.day);
    setState(() {
      activityCompleted[date] = true;
      activityEntered[date] = true;
      activityCompletionDate[date] = cleanToday;
    });

    _saveProgress();
  }

  String _calcularEstado(DateTime fechaSesion) {
    final hoy = DateTime.now();
    final hoySinHora = DateTime(hoy.year, hoy.month, hoy.day);
    final fechaSesionSinHora = DateTime(fechaSesion.year, fechaSesion.month, fechaSesion.day);
    final completado = activityCompleted[fechaSesion] ?? false;
    final fechaCompletado = activityCompletionDate[fechaSesion];

    if (completado && fechaCompletado != null) {
      if (_isSameDay(fechaCompletado, fechaSesion)) {
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

  bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F8FA),
      appBar: AppBar(
        title: Text("Actividades - Mes 5"),
        backgroundColor: Colors.teal.shade400,
        elevation: 4,
      ),
      body: Column(
        children: [
          if (!showCalendar)
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                title: Text("Selecciona tu fecha de inicio"),
                content: Text("Elige el día en que deseas iniciar las actividades del mes 5."),
                actions: [
                  TextButton(
                    onPressed: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );

                      if (picked != null) {
                        _selectedDate = picked;
                        _generateActivities(picked);
                        await _saveProgress();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('¡Progreso guardado desde ${picked.day}/${picked.month}/${picked.year}!'),
                            backgroundColor: Colors.teal,
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
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
                    selectedDayPredicate: (day) => _isSameDay(_selectedDate ?? DateTime.now(), day),
                    onDaySelected: (selected, focused) {
                      if (selected.isAfter(DateTime.now())) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: Text("Fecha inválida"),
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
                      todayDecoration: BoxDecoration(color: Colors.teal.shade300, shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(color: Colors.teal, shape: BoxShape.circle),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(color: Colors.teal.shade100),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        final todayOnly = DateTime.now();
                        final cleanDay = DateTime(day.year, day.month, day.day);
                        if (activities.containsKey(cleanDay)) {
                          if (activityCompleted[cleanDay] == true) {
                            final completedOn = activityCompletionDate[cleanDay];
                            if (completedOn != null) {
                              if (_isSameDay(completedOn, cleanDay)) return Center(child: Text("✅"));
                              if (completedOn.isAfter(cleanDay)) return Center(child: Text("⏰"));
                            }
                          } else if (cleanDay.isBefore(todayOnly)) {
                            return Center(child: Text("❌"));
                          } else {
                            return Center(child: Text("👩🏼‍🍼"));
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final entry = activities.entries.elementAt(index);
                        final date = entry.key;
                        final page = entry.value;
                        final today = DateTime.now();
                        final isAvailable = date.isBefore(today) || _isSameDay(date, today);

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                          child: ListTile(
                            leading: Icon(Icons.assignment, color: Colors.teal),
                            title: Text("Sesión del ${date.day}/${date.month}/${date.year}"),
                            subtitle: Text("Estado: ${_calcularEstado(date)}"),
                            trailing: ElevatedButton(
                              onPressed: isAvailable
                                  ? () {
                                      if (!activityEntered[date]!) {
                                        _completeActivity(date, page);
                                      }
                                      Navigator.push(context, MaterialPageRoute(builder: (_) => page));
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: isAvailable ? Colors.teal : Colors.grey,
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
                      onPressed: activityCompleted.values.every((v) => v)
                          ? () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (_) => VerdeEvaluacion5Page()),
                              );
                            }
                          : null,
                      icon: Icon(Icons.check_circle),
                      label: Text("Ir a Evaluación"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: activityCompleted.values.every((v) => v) ? Colors.green : Colors.grey,
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
















