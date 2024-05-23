import 'package:appdevfinal/InicioAppAdmin.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class CitasReb extends StatefulWidget {
  const CitasReb({Key? key}) : super(key: key);

  @override
  State<CitasReb> createState() => _CitasRebState();
}

class _CitasRebState extends State<CitasReb> {
  final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref();
  final List<Map<dynamic, dynamic>> _citas = [];
  final List<String> _keys = [];

  @override
  void initState() {
    super.initState();
    _getCitas();
  }

  void _getCitas() {
    _databaseReference.child('citas').onValue.listen((event) {
      setState(() {
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
      });
    }, onError: (error) {
      print('Error al obtener datos: $error');
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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => AdminPage()),
            );
          },
        ),
        title: Text('Citas Registradas'),
      ),
      body: _citas.isEmpty
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _citas.length,
              itemBuilder: (BuildContext context, int index) {
                if (index < 0 || index >= _citas.length || index >= _keys.length) {
                  return SizedBox.shrink();
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
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteCita(key);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.check),
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
