import 'package:appdevfinal/ForoDiscussion.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Createforo extends StatefulWidget {
  const Createforo({super.key});

  @override
  State<Createforo> createState() => _CreateforoState();
}

class _CreateforoState extends State<Createforo> {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const Forodiscussion()));
          },
        ),
        title: const Text('Crea un nuevo foro'),
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: tituloController,
              decoration: InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  final titulo = tituloController.text.trim();
                  final descripcion = descripcionController.text.trim();

                  if (titulo.isEmpty || descripcion.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, completa todos los campos.'),
                        backgroundColor: Colors.red,
                      ),
                    );
                    return;
                  }

                  try {
                    // Crear el documento en Firestore
                    await FirebaseFirestore.instance.collection('foros').add({
                      'titulo': titulo,
                      'descripcion': descripcion,
                      'fechaCreacion': Timestamp.now(),
                      'autor':
                          'Usuario Anónimo', // Cambia esto si tienes autenticación
                      'rating': 0.0, // Inicializamos el rating en 0.0
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Foro creado exitosamente.'),
                        backgroundColor: Colors.green,
                      ),
                    );

                    // Regresar a la pantalla anterior
                    Navigator.pop(context);
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error al crear el foro: $e'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: Text('Publicar Foro'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
