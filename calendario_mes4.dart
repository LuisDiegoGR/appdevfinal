import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarioMes4Page extends StatefulWidget {
  @override
  _CalendarioMes4PageState createState() => _CalendarioMes4PageState();
}

class _CalendarioMes4PageState extends State<CalendarioMes4Page> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  // Lista de días con sesiones (tres sesiones a la semana durante un mes)
  List<DateTime> sessionDays = [];

  @override
  void initState() {
    super.initState();
  }

  // Genera las fechas de las sesiones 3 veces a la semana durante un mes
  void _generateSessionDays(DateTime startDate) {
    sessionDays.clear(); // Limpiar la lista de días antes de agregar nuevas sesiones

    // Empezamos con la fecha seleccionada y calculamos las tres sesiones por semana
    int weekday = startDate.weekday;

    // Ajustamos la primera sesión (lunes, por ejemplo)
    int daysToMonday = (DateTime.monday - weekday + 7) % 7;
    int daysToWednesday = (DateTime.wednesday - weekday + 7) % 7;
    int daysToFriday = (DateTime.friday - weekday + 7) % 7;

    DateTime firstMonday = startDate.add(Duration(days: daysToMonday));
    DateTime firstWednesday = startDate.add(Duration(days: daysToWednesday));
    DateTime firstFriday = startDate.add(Duration(days: daysToFriday));

    // Añadimos las sesiones de un mes
    for (int i = 0; i < 4; i++) {
      sessionDays.add(firstMonday.add(Duration(days: i * 7)));
      sessionDays.add(firstWednesday.add(Duration(days: i * 7)));
      sessionDays.add(firstFriday.add(Duration(days: i * 7)));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario Mes 4'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Selecciona la fecha de inicio del programa',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                // Generar las sesiones cuando se selecciona una fecha de inicio
                _generateSessionDays(selectedDay);
              });
            },
            calendarFormat: _calendarFormat,
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarBuilders: CalendarBuilders(
              markerBuilder: (context, date, events) {
                // Marca los días de sesión con un emoji 🎉
                if (sessionDays.any((d) => isSameDay(d, date))) {
                  return Positioned(
                    bottom: 1,
                    child: Text(
                      '🎉',
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }
                return null;
              },
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Fecha seleccionada'),
                  content: Text(
                    'Has seleccionado el día ${_selectedDay.day}/${_selectedDay.month}/${_selectedDay.year} como fecha de inicio.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('Cerrar'),
                    ),
                  ],
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Seleccionar Fecha',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}






