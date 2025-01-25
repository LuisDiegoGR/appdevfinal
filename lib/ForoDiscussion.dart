import 'package:appdevfinal/CreateForo.dart';
import 'package:appdevfinal/page_foro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Forodiscussion extends StatefulWidget {
  const Forodiscussion({super.key});

  @override
  State<Forodiscussion> createState() => _ForodiscussionState();
}

class _ForodiscussionState extends State<Forodiscussion> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => PageForo()));
          },
        ),
        title: const Text(
          'Foros de discusión',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('foros').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          final foros = snapshot.data!.docs;
          return ListView.builder(
            itemCount: foros.length,
            itemBuilder: (context, index) {
              final foro = foros[index];
              return ListTile(
                tileColor: const Color.fromARGB(255, 241, 241, 241),
                leading: const Icon(Icons.group),
                trailing: const Icon(Icons.arrow_forward_ios),
                contentPadding: const EdgeInsets.all(10),
                title: Text(foro['titulo']),
                subtitle: Text(foro['descripcion']),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ForoDetalle(foroId: foro.id),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Createforo()),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class ForoDetalle extends StatefulWidget {
  final String foroId;

  ForoDetalle({required this.foroId});

  @override
  _ForoDetalleState createState() => _ForoDetalleState();
}

class _ForoDetalleState extends State<ForoDetalle> {
  double _userRating = 1.0;

  void _rateForo(double rating) async {
    try {
      final foroRef =
          FirebaseFirestore.instance.collection('foros').doc(widget.foroId);

      // Añadir la nueva valoración a una subcolección "valoraciones"
      await foroRef.collection('valoraciones').add({'rating': rating});

      // Obtener todas las valoraciones acumuladas
      final valoracionesSnapshot =
          await foroRef.collection('valoraciones').get();
      final valoraciones = valoracionesSnapshot.docs
          .map((doc) => doc['rating'] as double)
          .toList();

      // Calcular el promedio
      final promedio = valoraciones.isNotEmpty
          ? valoraciones.reduce((a, b) => a + b) / valoraciones.length
          : 0.0;

      // Actualizar el campo "rating" con el promedio general
      await foroRef.update({'rating': promedio});

      // Actualizar el estado local
      setState(() {
        _userRating =
            rating; // Guarda la última valoración dada por este usuario
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Valoración registrada.'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al registrar la valoración: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalles del Foro')),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('foros')
            .doc(widget.foroId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());

          final foro = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foro['titulo'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      foro['descripcion'],
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Text(
                          'Valoración: ${foro['rating']?.toStringAsFixed(1) ?? 'Sin valoraciones'}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(width: 20),
                        IconButton(
                          icon: Icon(Icons.star, color: Colors.amber),
                          onPressed: () {
                            _showRatingDialog();
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Divider(),
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('foros')
                      .doc(widget.foroId)
                      .collection('comentarios')
                      .orderBy('fechaComentario')
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData)
                      return Center(child: CircularProgressIndicator());
                    final comentarios = snapshot.data!.docs;
                    return ListView.builder(
                      itemCount: comentarios.length,
                      itemBuilder: (context, index) {
                        final comentario = comentarios[index];
                        return ListTile(
                          title: Text(comentario['contenido']),
                          subtitle: Text('Por: ${comentario['autor']}'),
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Escribe un comentario...',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (value) async {
                    if (value.isNotEmpty) {
                      final user = FirebaseAuth
                          .instance.currentUser; // Obtén el usuario actual
                      if (user != null) {
                        // Obtener el nombre desde Firestore usando el UID del usuario
                        final userSnapshot = await FirebaseFirestore.instance
                            .collection('users')
                            .doc(user.uid)
                            .get();

                        String username =
                            'Usuario Anónimo'; // Valor predeterminado
                        if (userSnapshot.exists) {
                          final userData = userSnapshot.data();
                          username = userData?['name'] ??
                              'Usuario Anónimo'; // Suponiendo que el campo en Firestore se llama 'nombre'
                        }

                        // Ahora guarda el comentario en Firestore con el nombre del usuario
                        await FirebaseFirestore.instance
                            .collection('foros')
                            .doc(widget.foroId)
                            .collection('comentarios')
                            .add({
                          'contenido': value,
                          'autor': username, // Usa el nombre del usuario
                          'fechaComentario': Timestamp.now(),
                        });
                      }
                    }
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showRatingDialog() {
    showDialog(
      context: context,
      builder: (context) {
        double tempRating =
            _userRating; // Valor temporal para manejar el deslizamiento

        return AlertDialog(
          title: Text('Valorar Foro'),
          content: StatefulBuilder(
            builder: (context, setDialogState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Selecciona una valoración:'),
                  Slider(
                    value: tempRating,
                    min: 1,
                    max: 5,
                    divisions: 4,
                    label: tempRating.toStringAsFixed(1),
                    onChanged: (value) {
                      setDialogState(() {
                        tempRating = value; // Actualizamos el valor temporal
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _userRating = tempRating; // Guardamos el valor seleccionado
                });
                _rateForo(
                    _userRating); // Llamamos la función para guardar la valoración
                Navigator.pop(context);
              },
              child: Text('Valorar'),
            ),
          ],
        );
      },
    );
  }
}
