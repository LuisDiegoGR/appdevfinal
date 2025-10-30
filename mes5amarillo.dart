import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Mes5Amarillo extends StatefulWidget {
  @override
  _Mes5AmarilloState createState() => _Mes5AmarilloState();
}

class _Mes5AmarilloState extends State<Mes5Amarillo> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _sessions = {};

  @override
  void initState() {
    super.initState();
    _generateSessions();
  }

  void _generateSessions() {
    DateTime start = DateTime.now();
    for (int i = 0; i < 30; i++) {
      DateTime day = start.add(Duration(days: i));
      if (day.weekday != DateTime.saturday && day.weekday != DateTime.sunday) {
        _sessions[DateTime(day.year, day.month, day.day)] = ['📅 Sesión de estimulación'];
      }
    }
  }

  List<String> _getEventsForDay(DateTime day) {
    return _sessions[DateTime(day.year, day.month, day.day)] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes 5 Amarillo'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: _getEventsForDay,
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.yellow[300],
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: _selectedDay == null || _getEventsForDay(_selectedDay!).isEmpty
                ? Center(child: Text('No hay sesiones para esta fecha'))
                : ListView(
                    children: _getEventsForDay(_selectedDay!)
                        .map((event) => ListTile(
                              title: Text(event),
                            ))
                        .toList(),
                  ),
          ),
        ],
      ),
    );
  }
}




