import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';

class ChatScreen extends StatefulWidget {
  final String chatId;
  final String receiverName;
  final String receiverId;

  ChatScreen({required this.chatId, required this.receiverName, required this.receiverId});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController messageController = TextEditingController();
  TextEditingController imageMessageController = TextEditingController();
  String currentUserId = FirebaseAuth.instance.currentUser!.uid;
  Uint8List? imagenSeleccionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat con ${widget.receiverName}', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('chats')
                  .doc(widget.chatId)
                  .collection('messages')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) return Center(child: CircularProgressIndicator());

                return ListView.builder(
                  reverse: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var message = snapshot.data!.docs[index];
                    var messageData = message.data() as Map<String, dynamic>;
                    bool isMe = messageData['senderId'] == currentUserId;

                    return GestureDetector(
                      onLongPress: isMe
                          ? () {
                              _showMessageOptions(context, message.id, messageData['text']);
                            }
                          : null,
                      child: Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                            color: isMe ? Colors.pinkAccent : Colors.grey[100],
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 6,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                            children: [
                              if (messageData.containsKey('image') && messageData['image'] != null)
                                Column(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Uint8List imagen = Uint8List.fromList(List<int>.from(messageData['image']));
                                        _mostrarImagenAmpliada(imagen);
                                      },
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.memory(
                                          Uint8List.fromList(List<int>.from(messageData['image'])),
                                          height: 160,
                                          width: 160,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                              if (messageData.containsKey('text') && messageData['text'] != null)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Flexible(
                                      child: Text(
                                        messageData['text'] ?? '',
                                        style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 16),
                                      ),
                                    ),
                                    if (isMe) ...[
                                      SizedBox(width: 8),
                                      PopupMenuButton<String>(
                                        icon: Icon(Icons.more_vert, size: 22, color: isMe ? Colors.white : Colors.black87),
                                        onSelected: (value) {
                                          if (value == 'edit') {
                                            _editMessage(message.id, messageData['text']);
                                          } else if (value == 'delete') {
                                            _deleteMessage(message.id);
                                          }
                                        },
                                        itemBuilder: (BuildContext context) => [
                                          PopupMenuItem(value: 'edit', child: Text('Editar')),
                                          PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              SizedBox(height: 6),
                              Text(
                                (messageData['timestamp'] as Timestamp?)?.toDate().toLocal().toString().substring(11, 16) ??
                                    'Hora desconocida',
                                style: TextStyle(fontSize: 12, color: isMe ? Colors.white70 : Colors.black54),
                              ),
                            ],
                          ),
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
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.image, color: Colors.pinkAccent, size: 28),
            onPressed: _seleccionarImagen,
          ),
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Escribe un mensaje...',
                hintStyle: TextStyle(color: Colors.pinkAccent),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
                filled: true,
                fillColor: Colors.grey[50],
                contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              ),
            ),
          ),
          SizedBox(width: 10),
          IconButton(
            icon: Icon(Icons.send, color: Colors.pinkAccent, size: 28),
            onPressed: _sendMessage,
          ),
        ],
      ),
    );
  }

  Future<void> _seleccionarImagen() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final Uint8List bytes = await pickedFile.readAsBytes();
      Uint8List compressedImage = await _comprimirImagen(bytes);

      setState(() {
        imagenSeleccionada = compressedImage;
      });

      _mostrarVistaPrevia();
    }
  }

  void _mostrarVistaPrevia() {
    imageMessageController.clear();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Vista previa", style: TextStyle(color: Colors.pinkAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (imagenSeleccionada != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.memory(imagenSeleccionada!, height: 200, width: 200, fit: BoxFit.cover),
                ),
              SizedBox(height: 10),
              TextField(
                controller: imageMessageController,
                decoration: InputDecoration(hintText: "Añadir mensaje...", border: OutlineInputBorder()),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  imagenSeleccionada = null;
                });
                Navigator.pop(context);
              },
              child: Text("Cancelar", style: TextStyle(color: Colors.pinkAccent)),
            ),
            TextButton(
              onPressed: () {
                _sendImageMessage();
                Navigator.pop(context);
              },
              child: Text("Enviar", style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    FirebaseFirestore.instance.collection('chats').doc(widget.chatId).collection('messages').add({
      'senderId': currentUserId,
      'receiverId': widget.receiverId,
      'text': messageController.text.trim(),
      'timestamp': FieldValue.serverTimestamp(),
    });

    messageController.clear();
  }

  void _sendImageMessage() {
    if (imagenSeleccionada == null) return;

    FirebaseFirestore.instance.collection('chats').doc(widget.chatId).collection('messages').add({
      'senderId': currentUserId,
      'receiverId': widget.receiverId,
      'image': imagenSeleccionada!.toList(),
      'text': imageMessageController.text.trim().isNotEmpty ? imageMessageController.text.trim() : null,
      'timestamp': FieldValue.serverTimestamp(),
    });

    setState(() {
      imagenSeleccionada = null;
    });
  }

  Future<Uint8List> _comprimirImagen(Uint8List bytes) async {
    final result = await FlutterImageCompress.compressWithList(
      bytes,
      minHeight: 800,
      minWidth: 800,
      quality: 60,
    );
    return Uint8List.fromList(result);
  }

  void _deleteMessage(String messageId) {
    FirebaseFirestore.instance
        .collection('chats')
        .doc(widget.chatId)
        .collection('messages')
        .doc(messageId)
        .delete();
  }

  void _editMessage(String messageId, String oldText) {
    TextEditingController editController = TextEditingController(text: oldText);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar mensaje', style: TextStyle(color: Colors.pinkAccent)),
          content: TextField(
            controller: editController,
            decoration: InputDecoration(hintText: 'Nuevo mensaje'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancelar', style: TextStyle(color: Colors.pinkAccent)),
            ),
            TextButton(
              onPressed: () {
                if (editController.text.trim().isNotEmpty) {
                  FirebaseFirestore.instance
                      .collection('chats')
                      .doc(widget.chatId)
                      .collection('messages')
                      .doc(messageId)
                      .update({'text': editController.text.trim()});
                }
                Navigator.pop(context);
              },
              child: Text('Guardar', style: TextStyle(color: Colors.pinkAccent)),
            ),
          ],
        );
      },
    );
  }

  void _mostrarImagenAmpliada(Uint8List imagen) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          child: Image.memory(imagen),
        );
      },
    );
  }

  void _showMessageOptions(BuildContext context, String messageId, String messageText) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Opciones de mensaje', style: TextStyle(color: Colors.pinkAccent)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Mensaje: $messageText'),
              SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  _editMessage(messageId, messageText);
                  Navigator.pop(context);
                },
                child: Text('Editar', style: TextStyle(color: Colors.pinkAccent)),
              ),
              TextButton(
                onPressed: () {
                  _deleteMessage(messageId);
                  Navigator.pop(context);
                },
                child: Text('Eliminar', style: TextStyle(color: Colors.pinkAccent)),
              ),
            ],
          ),
        );
      },
    );
  }
}










