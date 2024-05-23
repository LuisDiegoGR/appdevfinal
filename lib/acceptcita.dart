import 'package:appdevfinal/InicioAppAdmin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AcceptCita extends StatefulWidget {
  const AcceptCita({Key? key}) : super(key: key);

  @override
  State<AcceptCita> createState() => _AcceptCitaState();
}

class _AcceptCitaState extends State<AcceptCita> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final List<Map<dynamic, dynamic>> _acceptedCitas = [];

  @override
  void initState() {
    super.initState();
    _getAcceptedCitas();
  }

  void _getAcceptedCitas() {
    _databaseReference.child('AccepCit').onValue.listen((event) {
      setState(() {
        _acceptedCitas.clear();
        Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            if (value != null && value is Map) {
              _acceptedCitas.add(value);
            }
          });
        }
      });
    }, onError: (error) {
      print('Error al obtener datos: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminPage()),
            );
          },
        ),
        title: Text('Citas Aceptadas'),
      ),
      body: _acceptedCitas.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _acceptedCitas.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < 0 || index >= _acceptedCitas.length) {
                  return SizedBox.shrink();
                }
                Map<dynamic, dynamic> cita = _acceptedCitas[index];
                return ListTile(
                  title: Text('Paciente: ${cita['paciente'] ?? 'Desconocido'}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fecha: ${cita['fecha'] ?? 'Desconocida'}'),
                      Text('Descripción: ${cita['descripcion'] ?? 'Sin descripción'}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
