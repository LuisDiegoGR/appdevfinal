import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'actividad_agarremes3.dart';
import 'actividad_cuellomes3.dart';
import 'actividad_Desarrollomotrizmes3.dart';
import 'actividad_neurologicomes3.dart';
import 'actividad_audicionmes3.dart';
import 'actividad_vista_tactomes3.dart';
import 'evaluacion3meses.dart';

class Mes3Page extends StatefulWidget {
  @override
  _Mes3PageState createState() => _Mes3PageState();
}

class _Mes3PageState extends State<Mes3Page> {
  DateTime? _selectedDate;
  DateTime _focusedDate = DateTime.now();
  Map<DateTime, Widget> activities = {};
  Map<DateTime, bool> activityCompleted = {};
  Map<DateTime, bool> activityEntered = {};
  Map<DateTime, DateTime> activityCompletionDate = {};
  Map<DateTime, String> nombreSesionPorFecha = {};
  bool showCalendar = false;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  String? nombreUsuario;
  String? apellidoUsuario;

  final List<String> estimulos = [
    "agarre",
    "cuello",
    "Desarrollomotriz",
    "neurologico",
    "audicion",
    "vista_tacto"
  ];

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
    nombreSesionPorFecha.clear();

    List<Widget> activityPages = [
      ActividadAgarreMes3(),
      ActividadCuelloMes3(),
      ActividadDesarrollomotrizMes3(),
      ActividadNeurologicoMes3(),
      ActividadAudicionMes3(),
      ActividadVistaTactoMes3(),
    ];

    for (int i = 0; i < 30; i++) {
      DateTime date = startDate.add(Duration(days: i));
      Widget page = activityPages[i % activityPages.length];
      String estimulo = estimulos[i % estimulos.length];
      activities[date] = page;
      activityCompleted[date] = false;
      activityEntered[date] = false;
      nombreSesionPorFecha[date] = estimulo;
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
        activityCompleted.map((k, v) => MapEntry(k.toIso8601String(), v));
    Map<String, bool> enteredMap =
        activityEntered.map((k, v) => MapEntry(k.toIso8601String(), v));
    Map<String, String> completionDateMap = activityCompletionDate
        .map((k, v) => MapEntry(k.toIso8601String(), v.toIso8601String()));

    await prefs.setString('selectedDateMes3', _selectedDate?.toIso8601String() ?? '');
    await prefs.setString('completedMes3', json.encode(completedMap));
    await prefs.setString('enteredMes3', json.encode(enteredMap));
    await prefs.setString('completionDatesMes3', json.encode(completionDateMap));

    await _saveProgressToFirebase();
  }

  Future<void> _saveProgressToFirebase() async {
    final user = _auth.currentUser;
    if (user == null || nombreUsuario == null || apellidoUsuario == null) return;

    final docId = '${nombreUsuario}_$apellidoUsuario';
    final progresoRef = _firestore.collection('progreso_mes3').doc(docId);

    await progresoRef.set({
      'fecha_inicio': _selectedDate?.toIso8601String() ?? '',
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    });

    int sesionNum = 1;
    for (final entry in activities.entries) {
      final date = entry.key;
      final actividadDoc = progresoRef.collection('actividades').doc('sesion$sesionNum');

      final nombreSesion = nombreSesionPorFecha[date] ?? 'desconocido';
      final realizadoTexto = activityCompleted[date] == true ? 'realizado - $nombreSesion' : '';
      final entroTexto = activityEntered[date] == true ? 'realizado - $nombreSesion' : '';
      final fechaCompletado = activityCompletionDate[date]?.toIso8601String();

      final estado = calcularEstado(date);

      await actividadDoc.set({
        'fecha_sesion': date.toIso8601String(),
        'completado': realizadoTexto,
        'entro': entroTexto,
        'fecha_completado': fechaCompletado ?? '',
        'estado': estado,
      }, SetOptions(merge: true));

      sesionNum++;
    }
  }

  String calcularEstado(DateTime fechaSesion) {
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
    String? dateStr = prefs.getString('selectedDateMes3');

    if (dateStr != null && dateStr.isNotEmpty) {
      _selectedDate = DateTime.parse(dateStr);
      Map<String, dynamic> completedMap = json.decode(prefs.getString('completedMes3') ?? '{}');
      Map<String, dynamic> enteredMap = json.decode(prefs.getString('enteredMes3') ?? '{}');
      Map<String, dynamic> completionDatesMap = json.decode(prefs.getString('completionDatesMes3') ?? '{}');

      _generateActivities(_selectedDate!);

      activityCompleted =
          completedMap.map((k, v) => MapEntry(DateTime.parse(k), v));
      activityEntered =
          enteredMap.map((k, v) => MapEntry(DateTime.parse(k), v));
      activityCompletionDate = completionDatesMap.map(
          (k, v) => MapEntry(DateTime.parse(k), DateTime.parse(v)));

      setState(() => showCalendar = true);
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
          content: Text('¡Fecha de inicio guardada!'),
          backgroundColor: Colors.green.shade400,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFFAF1),
      appBar: AppBar(
        title: Text("Actividades - Mes 3"),
        backgroundColor: Colors.green.shade600,
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
                content: Text("Elige el día para comenzar el Mes 3."),
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
                        final today = DateTime.now();
                        final todayOnly = DateTime(today.year, today.month, today.day);

                        if (activities.containsKey(dayOnly)) {
                          final estado = calcularEstado(dayOnly);
                          switch (estado) {
                            case "Hecho a tiempo":
                              return Center(child: Text("✅"));
                            case "Hecho a destiempo":
                              return Center(child: Text("⏰"));
                            case "No completado":
                              return Center(child: Text("❌"));
                            case "Pendiente":
                              return Center(child: Text("🧸"));
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

                        final estado = calcularEstado(date);
                        final nombreSesion = nombreSesionPorFecha[date] ?? 'Sesión';

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 4,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: Icon(Icons.nature_people, color: Colors.green.shade600),
                            title: Text(
                              "$nombreSesion - ${date.day}/${date.month}/${date.year}",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            subtitle: Text("Estado: $estado"),
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
                                MaterialPageRoute(builder: (_) => Evaluacion3MesesPage()),
                              );
                            }
                          : null,
                      icon: Icon(Icons.check_circle),
                      label: Text("Ir a Evaluación"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            activityCompleted.values.every((v) => v) ? Colors.teal : Colors.grey,
                        minimumSize: Size(double.infinity, 50),
                        shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
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














