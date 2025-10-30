import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';


class Mes6Amarillo extends StatefulWidget {
  @override
  _Mes6AmarilloState createState() => _Mes6AmarilloState();
}

class _Mes6AmarilloState extends State<Mes6Amarillo> {
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
        title: Text('Mes 6 Amarillo', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow[100],
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(10),
            child: TableCalendar(
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
                  color: Colors.orangeAccent,
                  shape: BoxShape.circle,
                ),
                selectedDecoration: BoxDecoration(
                  color: Colors.deepOrange,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: _selectedDay == null || _getEventsForDay(_selectedDay!).isEmpty
                  ? Center(child: Text('No hay sesiones para esta fecha', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)))
                  : ListView(
                      children: _getEventsForDay(_selectedDay!)
                          .map((event) => ListTile(
                                leading: Icon(Icons.event, color: Colors.amber),
                                title: Text(event, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                              ))
                          .toList(),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

