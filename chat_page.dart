import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'mensajes_chat.dart'; // Importamos el archivo que maneja los mensajes

class ChatPage extends StatefulWidget {
  final String temaId;
  final String titulo;

  ChatPage(this.temaId, this.titulo);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  String userName = "name";

  @override
  void initState() {
    super.initState();
    _cargarUsuario();
  }

  void _cargarUsuario() async {
    String uid = FirebaseAuth.instance.currentUser?.uid ?? '';
    if (uid.isNotEmpty) {
      var userSnapshot = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userSnapshot.exists) {
        setState(() {
          userName = userSnapshot['name'] ?? "Usuario Anónimo1";
        });
      }
    }
  }

  void _enviarMensaje() async {
    if (_controller.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('temas').doc(widget.temaId).collection('chats').add({
        'usuario': userName,
        'mensaje': _controller.text,
        'timestamp': FieldValue.serverTimestamp(),
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.titulo)),
      body: Column(
        children: [
          Expanded(child: MensajesChat(widget.temaId)), // Aquí se carga la lista de mensajes desde el otro archivo
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            spreadRadius: 2,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              
            ),
          ),
          SizedBox(width: 10),
          
        ],
      ),
    );
  }
}


