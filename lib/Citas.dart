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
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const TerceraPag())
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Spacer(),
              Container(
                width: 400,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Nombre del Paciente',
                  border: InputBorder.none,
                ),
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
          ),
          SizedBox(height: 30),
          Container(
                width: 400,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Fecha de la Cita',
                  border: InputBorder.none,
                ),
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
          ),
          SizedBox(height: 30),
          Container(
                width: 400,
                padding: const EdgeInsets.all(9),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 231, 230, 230),
                  borderRadius: BorderRadius.circular(20.0),
                ),
              child: TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Descripción de la Cita',
                  border: InputBorder.none,
                ),
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
          ),
          SizedBox(height: 30),
          RawMaterialButton(
                    fillColor: const Color(0xFF145647), 
                    elevation: 0.0,
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _registrarCita();
                    }
                  },
                  child: const Text(
                    'Registrar Cita',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                ),
              
              Spacer(),
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
          const SnackBar(content: Text('Cita registrada exitosamente')),
        );
        _formKey.currentState!.reset();
      }).catchError((error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al registrar la cita: $error')),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: Usuario no autenticado')),
      );
    }
  }
}
