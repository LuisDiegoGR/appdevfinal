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
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFFE8EAF6), Color(0xFF7986CB)],
              ),
            ),
          ),
          Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const AdminPage()),
                    );
                  },
                ),
              ),
              SizedBox(
                width: 250,
                height: 250,
                child: Image.asset('assets/images/doctora.png'),
              ),
              Expanded(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : _citas.isEmpty
                        ? const SizedBox.shrink()
                        : SingleChildScrollView(
                            child: ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: _citas.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (index < 0 ||
                                    index >= _citas.length ||
                                    index >= _keys.length) {
                                  return const SizedBox.shrink();
                                }
                                Map<dynamic, dynamic> cita = _citas[index];
                                String key = _keys[index];
                                return Padding(
                                  padding: const EdgeInsets.all(25),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    elevation: 5,
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
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
                                          const SizedBox(height: 4),
                                          Text('Descripción: ${cita['descripcion'] ?? 'Sin descripción'}'),
                                          const SizedBox(height: 16),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.red.withOpacity(0.2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(Icons.delete, color: Colors.red),
                                                  onPressed: () {
                                                    _deleteCita(key);
                                                  },
                                                ),
                                              ),
                                              const SizedBox(width: 16),
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.green.withOpacity(0.2),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: IconButton(
                                                  icon: const Icon(Icons.check, color: Colors.green),
                                                  onPressed: () {
                                                    _acceptCita(key, cita);
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
