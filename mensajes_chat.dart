import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';

class MensajesChat extends StatefulWidget {
  final String temaId;
  MensajesChat(this.temaId);

  @override
  _MensajesChatState createState() => _MensajesChatState();
}

class _MensajesChatState extends State<MensajesChat> {
  Uint8List? imagenSeleccionada;
  TextEditingController messageController = TextEditingController();
  String usuarioNombre = 'Usuario Anónimo';  // Inicializamos con un valor por defecto

  @override
  void initState() {
    super.initState();
    _obtenerNombreUsuario();  // Cargamos el nombre del usuario al inicio
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('temas')
                .doc(widget.temaId)
                .collection('mensajes_chat')
                .orderBy('timestamp')
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
              var mensajes = snapshot.data!.docs;

              return ListView.builder(
                itemCount: mensajes.length,
                itemBuilder: (context, index) {
                  var mensaje = mensajes[index];
                  var mensajeData = mensaje.data() as Map<String, dynamic>;

                  // Comparamos el nombre del usuario autenticado con el nombre del mensaje
                  bool esUsuarioActual = mensajeData['usuario'] == usuarioNombre;

                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: Align(
                      alignment: esUsuarioActual ? Alignment.centerRight : Alignment.centerLeft,  // Alineación según quién envió el mensaje
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: esUsuarioActual ? Colors.blue[200] : Colors.grey[300],  // Diferente color para el usuario actual
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mensajeData['usuario'],
                                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
                                ),
                                SizedBox(height: 4),
                                if (mensajeData.containsKey('imagen') && mensajeData['imagen'] != null)
                                  // Convertir la lista dinámica a una lista de enteros
                                  GestureDetector(
                                    onTap: () {
                                      // Mostrar la imagen en grande en una nueva pantalla
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ImageFullScreen(
                                            imageBytes: List<int>.from(mensajeData['imagen']),
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.memory(
                                        Uint8List.fromList(List<int>.from(mensajeData['imagen'])),
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                if (mensajeData.containsKey('mensaje') && mensajeData['mensaje'] != null)
                                  Text(mensajeData['mensaje']),
                              ],
                            ),
                          ),
                          // Solo mostrar el PopupMenuButton si el mensaje es del usuario actual
                          if (esUsuarioActual)
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                if (value == 'editar') {
                                  _mostrarDialogoEditar(mensaje.id, mensajeData['mensaje'], mensajeData['usuario']);
                                } else if (value == 'eliminar') {
                                  _eliminarMensaje(mensaje.id, mensajeData['usuario']);
                                }
                              },
                              itemBuilder: (BuildContext context) {
                                return [
                                  PopupMenuItem(value: 'editar', child: Text('Editar')),
                                  PopupMenuItem(value: 'eliminar', child: Text('Eliminar')),
                                ];
                              },
                              icon: Icon(Icons.more_vert, size: 20),
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.image, color: Colors.blueAccent),
            onPressed: _seleccionarImagen,
          ),
          Expanded(
            child: imagenSeleccionada == null
                ? TextField(
                    controller: messageController,
                    decoration: InputDecoration(
                      hintText: 'Escribe un mensaje...',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  )
                : Container(),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.send, color: Colors.blueAccent),
            onPressed: imagenSeleccionada == null ? _sendMessage : _sendImageMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List originalImageBytes = await pickedFile.readAsBytes();

      // Comprimir imagen
      final Uint8List? compressedImage = await FlutterImageCompress.compressWithList(
        originalImageBytes,
        minWidth: 800,
        minHeight: 800,
        quality: 70,
      );

      if (compressedImage != null) {
        setState(() {
          imagenSeleccionada = compressedImage;
        });

        _sendImageMessage();
      }
    }
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    FirebaseFirestore.instance
        .collection('temas')
        .doc(widget.temaId)
        .collection('mensajes_chat')
        .add({
      'usuario': usuarioNombre,  // Usamos el nombre del usuario autenticado
      'mensaje': messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    messageController.clear();
  }

  void _sendImageMessage() {
    if (imagenSeleccionada == null) return;

    FirebaseFirestore.instance
        .collection('temas')
        .doc(widget.temaId)
        .collection('mensajes_chat')
        .add({
      'usuario': usuarioNombre,  // Usamos el nombre del usuario autenticado
      'imagen': imagenSeleccionada!.toList(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      imagenSeleccionada = null;
    });
  }

  void _mostrarDialogoEditar(String mensajeId, String mensajeActual, String usuarioMensaje) {
    TextEditingController editarController = TextEditingController(text: mensajeActual);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Editar mensaje"),
        content: TextField(
          controller: editarController,
          decoration: InputDecoration(hintText: "Nuevo mensaje"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancelar"),
          ),
          TextButton(
            onPressed: () {
              _editarMensaje(mensajeId, editarController.text.trim(), usuarioMensaje);
              Navigator.pop(context);
            },
            child: Text("Guardar"),
          ),
        ],
      ),
    );
  }

  void _editarMensaje(String mensajeId, String nuevoMensaje, String usuarioMensaje) {
    // Verificamos si el usuario autenticado es el mismo que el autor del mensaje
    if (usuarioNombre != usuarioMensaje) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No puedes editar este mensaje.")),
      );
      return;  // No se permite la edición si el usuario no es el autor
    }

    if (nuevoMensaje.isEmpty) return;

    FirebaseFirestore.instance
        .collection('temas')
        .doc(widget.temaId)
        .collection('mensajes_chat')
        .doc(mensajeId)
        .update({'mensaje': nuevoMensaje});
  }

  void _eliminarMensaje(String mensajeId, String usuarioMensaje) {
    // Verificamos si el usuario autenticado es el mismo que el autor del mensaje
    if (usuarioNombre != usuarioMensaje) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("No puedes eliminar este mensaje.")),
      );
      return;  // No se permite la eliminación si el usuario no es el autor
    }

    FirebaseFirestore.instance
        .collection('temas')
        .doc(widget.temaId)
        .collection('mensajes_chat')
        .doc(mensajeId)
        .delete();
  }

  // Obtener el nombre del usuario autenticado
  Future<void> _obtenerNombreUsuario() async {
    try {
      User? usuario = FirebaseAuth.instance.currentUser;
      if (usuario != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(usuario.uid)
            .get();

        if (userSnapshot.exists) {
          setState(() {
            usuarioNombre = userSnapshot['name'] ?? 'Usuario Anónimo';  // Obtener el nombre del campo 'name'
          });
        } else {
          setState(() {
            usuarioNombre = 'Usuario Anónimo';  // Si no existe el documento, asignar valor por defecto
          });
        }
      }
    } catch (e) {
      print("Error al obtener el nombre del usuario: $e");
      setState(() {
        usuarioNombre = 'Usuario Anónimo';  // Si ocurre un error, asignar valor por defecto
      });
    }
  }
}

class ImageFullScreen extends StatelessWidget {
  final List<int> imageBytes;

  ImageFullScreen({required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Imagen Completa')),
      body: Center(
        child: Image.memory(
          Uint8List.fromList(imageBytes),
          fit: BoxFit.contain, // Ajustar para que la imagen se vea completa
        ),
      ),
    );
  }
}














