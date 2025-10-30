import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:convert';

import 'actividad_vistames1.dart';
import 'actividad_olfatomes1.dart';
import 'actividad_motrizmes1.dart';
import 'actividad_Desarrollo_vestibularmes1.dart';
import 'actividad_Neorologicames1.dart';
import 'actividad_audicionmes1.dart';

class Mes1Page extends StatefulWidget {
  @override
  _Mes1PageState createState() => _Mes1PageState();
}

class _Mes1PageState extends State<Mes1Page> {
  DateTime? _selectedDate;
  DateTime _focusedDate = DateTime.now();
  Map<DateTime, Widget> activities = {};
  Map<DateTime, bool> activityCompleted = {};
  Map<DateTime, bool> activityEntered = {};
  Map<DateTime, DateTime> activityCompletionDate = {};
  Map<DateTime, String> nombreSesionPorFecha = {};
  bool showCalendar = false;
  String? nombreUsuario;

  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Map<int, String> nombresSesiones = {
    0: 'vista',
    1: 'olfato',
    2: 'motriz',
    3: 'Desarrollo vestibular',
    4: 'Neorologica',
    5: 'audicion',
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
    nombreSesionPorFecha.clear();

    List<Widget> activityPages = [
      EstimVistaMes1(),
      ActividadOlfatoMes1(),
      ActividadMotrizMes1(),
      JuegoPage(),
      Video3Page(),
      ActividadAudicionMes1(),
    ];

    for (int i = 0; i < 30; i++) {
      DateTime activityDate = startDate.add(Duration(days: i));
      DateTime simpleDate = DateTime(activityDate.year, activityDate.month, activityDate.day);
      Widget page = activityPages[i % activityPages.length];
      String nombreSesion = nombresSesiones[i % activityPages.length]!;
      activities[simpleDate] = page;
      activityCompleted[simpleDate] = false;
      activityEntered[simpleDate] = false;
      nombreSesionPorFecha[simpleDate] = nombreSesion;
    }

    _saveProgress();

    setState(() {
      showCalendar = true;
      _focusedDate = startDate;
    });
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

  Future<void> _saveProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, bool> completedMap = activityCompleted.map((key, value) => MapEntry(key.toIso8601String(), value));
    Map<String, bool> enteredMap = activityEntered.map((key, value) => MapEntry(key.toIso8601String(), value));
    Map<String, String> completionDateMap = activityCompletionDate.map((key, value) => MapEntry(key.toIso8601String(), value.toIso8601String()));

    await prefs.setString('selectedDateMes1', _selectedDate?.toIso8601String() ?? '');
    await prefs.setString('completedMes1', json.encode(completedMap));
    await prefs.setString('enteredMes1', json.encode(enteredMap));
    await prefs.setString('completionDatesMes1', json.encode(completionDateMap));

    await _saveProgressToFirebase();
  }

  Future<void> _saveProgressToFirebase() async {
    if (_selectedDate == null) return;

    final userId = nombreUsuario ?? _auth.currentUser?.uid ?? 'usuario_demo';
    final progresoRef = _firestore.collection('progreso_mes1').doc(userId);

    await progresoRef.set({
      'fecha_inicio': _selectedDate!.toIso8601String(),
      'ultima_actualizacion': FieldValue.serverTimestamp(),
    });

    int sesionIndex = 1;

    for (final entry in activities.entries) {
      final date = entry.key;
      final actividadDoc = progresoRef.collection('actividades').doc('sesion$sesionIndex');

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

      sesionIndex++;
    }
  }

  Future<void> _loadProgress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? selectedDateStr = prefs.getString('selectedDateMes1');

    if (selectedDateStr != null && selectedDateStr.isNotEmpty) {
      _selectedDate = DateTime.parse(selectedDateStr);
      Map<String, dynamic> completedMap = json.decode(prefs.getString('completedMes1') ?? '{}');
      Map<String, dynamic> enteredMap = json.decode(prefs.getString('enteredMes1') ?? '{}');
      Map<String, dynamic> completionDatesMap = json.decode(prefs.getString('completionDatesMes1') ?? '{}');

      _generateActivities(_selectedDate!);

      activityCompleted = completedMap.map((key, value) => MapEntry(DateTime.parse(key), value));
      activityEntered = enteredMap.map((key, value) => MapEntry(DateTime.parse(key), value));
      activityCompletionDate = completionDatesMap.map((key, value) => MapEntry(DateTime.parse(key), DateTime.parse(value)));

      setState(() {
        showCalendar = true;
      });
    }
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
      await _saveProgress();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('¡Progreso guardado!'),
          backgroundColor: Colors.teal,
          duration: Duration(seconds: 3),
        ),
      );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 235, 160, 223),
      appBar: AppBar(
        title: Text("Actividades - Mes 1"),
        backgroundColor: const Color.fromARGB(255, 105, 190, 230),
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
                content: Text("Para comenzar, elige el día en que deseas iniciar las actividades del mes 1."),
                actions: [
                  TextButton(
                    onPressed: _selectDate,
                    style: TextButton.styleFrom(foregroundColor: Colors.teal),
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
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2100, 12, 31),
                    focusedDay: _focusedDate,
                    selectedDayPredicate: (day) => isSameDay(_selectedDate, day),
                    onDaySelected: (selectedDay, focusedDay) {
                      if (selectedDay.isAfter(DateTime.now())) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
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
                          _selectedDate = selectedDay;
                          _focusedDate = focusedDay;
                        });
                      }
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: BoxDecoration(color: const Color.fromARGB(255, 193, 155, 243), shape: BoxShape.circle),
                      selectedDecoration: BoxDecoration(color: const Color.fromARGB(255, 74, 195, 248), shape: BoxShape.circle),
                      markerDecoration: BoxDecoration(color: Colors.orange, shape: BoxShape.circle),
                      weekendTextStyle: TextStyle(color: Colors.redAccent),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      decoration: BoxDecoration(color: Colors.teal.shade100),
                    ),
                    calendarBuilders: CalendarBuilders(
                      markerBuilder: (context, day, events) {
                        final dayOnly = DateTime(day.year, day.month, day.day);
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
                              return Center(child: Text("👩🏼‍🍼"));
                          }
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: activities.length,
                      itemBuilder: (context, index) {
                        final entry = activities.entries.elementAt(index);
                        final date = entry.key;
                        final page = entry.value;
                        final nombre = nombreSesionPorFecha[date] ?? 'Sesión';

                        final now = DateTime.now();
                        final today = DateTime(now.year, now.month, now.day);
                        final isAvailable = date.isAtSameMomentAs(today) || date.isBefore(today) || (date.isAtSameMomentAs(_selectedDate!));

                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          child: ListTile(
                            leading: Icon(Icons.event_note, color: Colors.teal),
                            title: Text("${nombre.toUpperCase()} - ${date.day}/${date.month}/${date.year}"),
                            subtitle: Text("Estado: ${calcularEstado(date)}"),
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
                                backgroundColor: isAvailable ? Colors.teal : Colors.grey,
                              ),
                              child: Text("Ir a sesión"),
                            ),
                          ),
                        );
                      },
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

















