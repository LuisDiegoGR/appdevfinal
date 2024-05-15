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

  @override
  void initState() {
    super.initState();
    _getCitas();
  }

void _getCitas() {
  _databaseReference.child('citas').onValue.listen((event) {
    setState(() {
      _citas.clear();
      Map<dynamic, dynamic>? values = event.snapshot.value as Map<dynamic, dynamic>?;
      if (values != null) {
        values.forEach((key, value) {
          _citas.add(value);
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
        title: Text('Citas Registradas'),
      ),
      body: _citas.isEmpty
          ? Center(
              child: Text('No hay citas registradas'),
            )
          : ListView.builder(
              itemCount: _citas.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text('Paciente: ${_citas[index]['paciente']}'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fecha: ${_citas[index]['fecha']}'),
                      Text('Descripción: ${_citas[index]['descripcion']}'),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
