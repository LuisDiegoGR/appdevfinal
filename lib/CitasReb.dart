import 'dart:async';

import 'package:appdevfinal/InicioAppAdmin.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CitasReb extends StatefulWidget {
  const CitasReb({super.key});

  @override
  State<CitasReb> createState() => _CitasRebState();
}

class _CitasRebState extends State<CitasReb> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final List<Map<dynamic, dynamic>> _citas = [];
  final List<String> _keys = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getCitas();
  }

  void _getCitas() {
    _databaseReference.child('citas').onValue.listen((event) {
      setState(() {
        _isLoading = false;
        _citas.clear();
        _keys.clear();
        Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;
        if (values != null) {
          values.forEach((key, value) {
            if (value != null && value is Map) {
              _citas.add(value);
              _keys.add(key);
            }
          });
        }
        if (_citas.isEmpty) {
          _showSnackBar();
        }
      });
    }, onError: (error) {
      print('Error al obtener datos: $error');
    });
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Sin citas registradas'),
        duration: Duration(seconds: 5),
      ),
    );
    Timer(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AdminPage()),
      );
    });
  }

  void _deleteCita(String key) {
    _databaseReference.child('citas').child(key).remove().then((_) {
      print('Cita eliminada correctamente');
      setState(() {
        int index = _keys.indexOf(key);
        if (index != -1) {
          _citas.removeAt(index);
          _keys.removeAt(index);
        }
      });
    }).catchError((error) {
      print('Error al eliminar la cita: $error');
    });
  }

  void _acceptCita(String key, Map<dynamic, dynamic> cita) {
    _databaseReference.child('AccepCit').child(key).set(cita).then((_) {
      print('Cita aceptada correctamente');
      _deleteCita(key);
    }).catchError((error) {
      print('Error al aceptar la cita: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const AdminPage()),
            );
          },
        ),
        title: const Text('Citas Registradas'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _citas.isEmpty
              ? const SizedBox.shrink()
              : ListView.builder(
                  itemCount: _citas.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index < 0 ||
                        index >= _citas.length ||
                        index >= _keys.length) {
                      return const SizedBox.shrink();
                    }
                    Map<dynamic, dynamic> cita = _citas[index];
                    String key = _keys[index];
                    return ListTile(
                      title: Text('Paciente: ${cita['paciente'] ?? 'Desconocido'}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Fecha: ${cita['fecha'] ?? 'Desconocida'}'),
                          Text('Descripción: ${cita['descripcion'] ?? 'Sin descripción'}'),
                        ],
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              _deleteCita(key);
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.check),
                            onPressed: () {
                              _acceptCita(key, cita);
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
