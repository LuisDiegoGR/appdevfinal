import 'package:flutter/material.dart';

class ConsultarEspecialista extends StatefulWidget {
  const ConsultarEspecialista({super.key});

  @override
  _ConsultarEspecialistaState createState() => _ConsultarEspecialistaState();
}

class _ConsultarEspecialistaState extends State<ConsultarEspecialista> {
  final TextEditingController _textController = TextEditingController();
  final List<Map<String, dynamic>> _messages = []; 
  bool _showDoctorAvailability = true;

  void _sendMessage(String message) {
    setState(() {
      _messages.insert(0, {'text': message, 'isUser': true}); 
    });
    _textController.clear();

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _messages.insert(0, {
          'text': 'Respuesta de la Doctora Maria Eugenia: $message',
          'isUser': false
        });
      });
    });
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      setState(() {
        _showDoctorAvailability = false;
      });
    });
  }

  Widget _buildMessage(Map<String, dynamic> message, bool isUser) {
    final bgColor = isUser ? Colors.blue[100] : Colors.blue;
    final textColor = isUser ? Colors.black : Colors.white;
    final align = isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final icon = isUser ? Icons.person : Icons.person_outline;
    final borderRadius = isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomLeft: Radius.circular(12),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(12),
            topRight: Radius.circular(12),
            bottomRight: Radius.circular(12),
          );

    return Column(
      crossAxisAlignment: align,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: borderRadius,
          ),
          child: Text(
            message['text'],
            style: TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment:
              isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            if (!isUser) Icon(icon, color: Colors.grey),
            const SizedBox(width: 8),
            CircleAvatar(
              child: Icon(icon),
              backgroundColor: Colors.grey[200],
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AnimatedOpacity(
            duration: const Duration(seconds: 2),
            opacity: _showDoctorAvailability ? 1.0 : 0.0,
            curve: Curves.easeInOut,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'Especialista médico disponible de lunes a viernes de 14:00 a 15:00',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              reverse: true, 
              itemCount: _messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = _messages[index];
                final isUser = message['isUser'];
                return _buildMessage(message, isUser);
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
                    decoration: InputDecoration(
                      labelText: 'Consulta tus dudas',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
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

void main() {
  runApp(const MaterialApp(
    home: ConsultarEspecialista(),
  ));
}
