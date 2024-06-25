import 'package:appdevfinal/pantalla_siguiente.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

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
      extendBodyBehindAppBar: true,  // Extiende el cuerpo detrás del AppBar
      appBar: AppBar(
        backgroundColor: Colors.transparent,  // Hace transparente el AppBar
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color.fromARGB(255, 0, 0, 0)),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const PantallaSiguiente()),
            );
          },
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE8EAF6), Color(0xFF7986CB)],
          ),
        ),
        child: Column(
          children: [
            // Agregamos un SizedBox para dar un margen superior
            const SizedBox(height: 80), // Ajusta esta altura según lo necesites
            Center(
              child: Image.asset(
                'assets/images/citas.png',
                width: 250,
                height: 250,
              ),
            ),
            const SizedBox(height: 1), // Espacio entre la imagen y el contenido
            Expanded(
              child: _acceptedCitas.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : SingleChildScrollView(
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
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
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
