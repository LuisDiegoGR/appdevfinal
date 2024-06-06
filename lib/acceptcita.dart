import 'package:appdevfinal/pantalla_siguiente.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class AcceptCita extends StatefulWidget {
  const AcceptCita({super.key});

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
        Map<dynamic, dynamic>? values =
            event.snapshot.value as Map<dynamic, dynamic>?;
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
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
            );
          },
        ),
      ),
      body: _acceptedCitas.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _acceptedCitas.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < 0 || index >= _acceptedCitas.length) {
                  return const SizedBox.shrink();
                }
                Map<dynamic, dynamic> cita = _acceptedCitas[index];
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Paciente: ${cita['paciente'] ?? 'Desconocido'}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              ),
                          ),
                          const SizedBox(height: 8),
                          Text('Fecha: ${cita['fecha'] ?? 'Desconocida'}'),
                          const SizedBox(height: 8),
                          Text('Descripción: ${cita['descripcion'] ?? 'Sin descripción'}'),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
