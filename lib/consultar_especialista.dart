import 'package:flutter/material.dart';

class ConsultarEspecialista extends StatefulWidget {
  const ConsultarEspecialista({super.key});

  @override
  _ConsultarEspecialistaState createState() => _ConsultarEspecialistaState();
}

class _ConsultarEspecialistaState extends State<ConsultarEspecialista> {
  final TextEditingController _textController = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage(String message) {
    setState(() {
      _messages.insert(0, message); // Insertar el nuevo mensaje al principio de la lista
    });
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Consultar Especialista'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              reverse: true, // Para que los mensajes más recientes aparezcan arriba
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text(_messages[index]),
                  leading: const Icon(Icons.message),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(labelText: 'Escribe un mensaje...'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _sendMessage(_textController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
