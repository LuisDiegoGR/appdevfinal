import 'package:appdevfinal/TerceraPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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

  Future<bool> _onWillPop() async {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const TerceraPag()),
    );
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const TerceraPag()),
              );
            },
          ),
          title: const Text(
            'Agendar Cita',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        extendBodyBehindAppBar: true,
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFFE8EAF6), Color(0xFF7986CB)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                      'assets/images/agend.png',
                      width: 280,
                      height: 280,
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 230, 230).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.person, color: Colors.black),
                          labelText: 'Nombre del Paciente',
                          labelStyle: TextStyle(color: Colors.black),
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
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 230, 230).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.calendar_today, color: Colors.black),
                          labelText: 'Fecha de la Cita',
                          labelStyle: TextStyle(color: Colors.black),
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
                    const SizedBox(height: 20),
                    Container(
                      width: 400,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 231, 230, 230).withOpacity(0.9),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: TextFormField(
                        cursorColor: Colors.black,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          icon: Icon(Icons.description, color: Colors.black),
                          labelText: 'Descripción de la Cita',
                          labelStyle: TextStyle(color: Colors.black),
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
                    const SizedBox(height: 30),
                    RawMaterialButton(
                      fillColor: Colors.black, 
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
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _registrarCita() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String uid = user.uid;
      databaseReference.child('citas').child(uid).push().set({
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
