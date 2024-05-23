import 'package:appdevfinal/TerceraPage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Citas extends StatefulWidget {
  const Citas({super.key});

  @override
  State<Citas> createState() => _CitasState();
}

class _CitasState extends State<Citas> {
  final databaseReference = FirebaseDatabase.instance.reference();
  final _formKey = GlobalKey<FormState>();
  String _nombrePaciente = '';
  String _fechaCita = '';
  String _descripcionCita = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => TerceraPag())
            );
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Nombre del Paciente'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese el nombre del paciente';
                  }
                  return null;
                },
                onSaved: (value) {
                  _nombrePaciente = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Fecha de la Cita'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese la fecha de la cita';
                  }
                  return null;
                },
                onSaved: (value) {
                  _fechaCita = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción de la Cita'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor ingrese la descripción de la cita';
                  }
                  return null;
                },
                onSaved: (value) {
                  _descripcionCita = value!;
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _registrarCita();
                    }
                  },
                  child: Text('Registrar Cita'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _registrarCita() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      databaseReference.child('citas').child(uid).set({
        'paciente': _nombrePaciente,
        'fecha': _fechaCita,
        'descripcion': _descripcionCita,
      }).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Cita registrada exitosamente')),
        );
        // Limpiar los campos después de registrar la cita
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar la cita: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Usuario no autenticado')),
      );
    }
  }
}
