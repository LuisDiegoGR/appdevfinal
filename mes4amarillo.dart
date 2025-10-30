import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Mes4Amarillo extends StatefulWidget {
  @override
  _Mes4AmarilloState createState() => _Mes4AmarilloState();
}

class _Mes4AmarilloState extends State<Mes4Amarillo> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  Map<DateTime, List<String>> _events = {};

  @override
  void initState() {
    super.initState();
    _generateSessionDays();
  }

  void _generateSessionDays() {
    DateTime now = DateTime.now();
    for (int i = 0; i < 30; i++) {
      DateTime day = now.add(Duration(days: i));
      if (day.weekday <= 5) { // Lunes a Viernes
        _events[DateTime(day.year, day.month, day.day)] = ['🟡 Sesión'];
      }
    }
  }

  void _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _focusedDay,
      firstDate: DateTime(2020, 1, 1),
      lastDate: DateTime(2030, 12, 31),
    );
    if (picked != null && picked != _selectedDay) {
      setState(() {
        _selectedDay = picked;
        _focusedDay = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mes 4 Amarillo'),
        backgroundColor: Colors.yellow[700],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text('Seleccionar Fecha'),
          ),
          SizedBox(height: 10),
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            eventLoader: (day) {
              return _events[DateTime(day.year, day.month, day.day)] ?? [];
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.orange,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView(
              children: _events[_selectedDay ?? DateTime.now()]?.map((event) {
                    return ListTile(
                      title: Text(event),
                    );
                  }).toList() ??
                  [Text('No hay sesiones en esta fecha')],
            ),
          ),
        ],
      ),
    );
  }
}


